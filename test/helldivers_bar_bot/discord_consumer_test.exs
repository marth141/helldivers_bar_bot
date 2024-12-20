defmodule HelldiversBarBot.DiscordConsumerTest do
  use HelldiversBarBot.DataCase
  use Mimic

  alias HelldiversBarBot.DiscordConsumer
  alias HelldiversBarBot.Drinks.Drink
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.User
  alias Nostrum.Struct.WSState

  describe "handle_event/1 balance" do
    test "balance interaction retrieves new helldiver and reports balance 0" do
      discord_id = 1234

      expect(Nostrum.Api, :create_interaction_response, fn _msg, response ->
        assert response == %{data: %{content: "Your balance is 0"}, type: 4}
        {:ok}
      end)

      expect(Nostrum.Api, :get_user, fn _user_id ->
        {:ok,
         %User{
           id: discord_id,
           username: "some username"
         }}
      end)

      assert {:ok} =
               DiscordConsumer.handle_event(
                 {:INTERACTION_CREATE,
                  %Interaction{
                    data: %ApplicationCommandInteractionData{
                      name: "balance"
                    },
                    user: %User{
                      id: 1234
                    }
                  }, %WSState{}}
               )

      assert %Helldiver{wallet: wallet} =
               Repo.get_by!(Helldiver, discord_id: to_string(discord_id))

      assert wallet == Decimal.new("0")
    end

    test "balance interaction reports wallet of existing user" do
      wallet_balance = "0.50"

      expect(Nostrum.Api, :create_interaction_response, fn _msg, response ->
        assert response == %{data: %{content: "Your balance is #{wallet_balance}"}, type: 4}
        {:ok}
      end)

      Repo.insert!(%Helldiver{discord_id: "1234", wallet: Decimal.new(wallet_balance)})

      assert {:ok} =
               DiscordConsumer.handle_event(
                 {:INTERACTION_CREATE,
                  %Interaction{
                    data: %ApplicationCommandInteractionData{
                      name: "balance"
                    },
                    user: %User{
                      id: 1234
                    }
                  }, %WSState{}}
               )
    end
  end

  describe "handle_event/1 buy_drink" do
    test "successful buy_drink interaction" do
      discord_buyer_id = 1234

      drink_price = "0.25"

      expect(Nostrum.Api, :create_interaction_response, fn _msg, _response -> {:ok} end)

      expect(Nostrum.Api, :get_user, fn _user_id ->
        {:ok,
         %User{
           id: discord_buyer_id,
           username: "some username"
         }}
      end)

      Repo.insert!(%Drink{
        name: "beer",
        cost: Decimal.new(drink_price),
        description: "some description"
      })

      assert {:ok} =
               DiscordConsumer.handle_event(
                 {:INTERACTION_CREATE,
                  %Interaction{
                    data: %ApplicationCommandInteractionData{
                      name: "buy_drink",
                      options: [
                        %{name: "drink", value: "beer"},
                        %{name: "user", value: 1235}
                      ]
                    },
                    user: %User{
                      id: discord_buyer_id
                    }
                  }, %WSState{}}
               ),
             "returns ok when interaction successfully responded"

      assert %Helldiver{} =
               helldiver = Repo.get_by(Helldiver, discord_id: to_string(discord_buyer_id)),
             "helldiver successfully retrieved from database"

      assert helldiver.wallet == Decimal.new("-#{drink_price}"),
             "helldiver wallet successfully charged"
    end
  end

  describe "handle_event/1 help" do
    test "successfully sends message on help command" do
      expect(Nostrum.Api, :create_interaction_response, fn _msg, response ->
        assert response == %{
                 data: %{
                   content: """
                   Hello there, I am your bartender. Here is a list of some commands you can issue me.

                   /balance - Gives the balance of a Helldiver's wallet
                   /buy_drink - Buys a drink for a Helldiver
                   /help - Displays this help message

                   Every message you send in the server will result in being rewarded with 0.25 bar credits.
                   These can be used to purchase drinks.
                   """
                 },
                 type: 4
               }

        {:ok}
      end)

      assert {:ok} =
               DiscordConsumer.handle_event(
                 {:INTERACTION_CREATE,
                  %Interaction{
                    data: %ApplicationCommandInteractionData{
                      name: "help"
                    }
                  }, %WSState{}}
               )
    end
  end
end

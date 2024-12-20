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
      expect(Nostrum.Api, :create_interaction_response, fn _msg, response ->
        assert response == %{data: %{content: "Your balance is 0"}, type: 4}
        {:ok}
      end)

      expect(Nostrum.Api, :get_user, fn _user_id ->
        {:ok,
         %User{
           id: 1234,
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
    end

    test "balance interaction reports wallet of existing user" do
      expect(Nostrum.Api, :create_interaction_response, fn _msg, response ->
        assert response == %{data: %{content: "Your balance is 0.50"}, type: 4}
        {:ok}
      end)

      Repo.insert!(%Helldiver{discord_id: "1234", wallet: Decimal.new("0.50")})

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
end

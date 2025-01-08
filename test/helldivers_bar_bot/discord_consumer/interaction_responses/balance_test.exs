defmodule HelldiversBarBot.DiscordConsumer.InteractionResponses.BalanceTest do
  use ExUnit.Case
  use HelldiversBarBot.DataCase
  use Mimic

  import Bitwise

  alias HelldiversBarBot.DiscordConsumer.InteractionResponses.Balance
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.User

  describe "main/1" do
    test "successfully sends a balance message to the user" do
      user_id = 12345

      expect(Nostrum.Api, :get_user, fn _user_id ->
        {:ok, %User{id: user_id, username: "some username"}}
      end)

      expect(Nostrum.Api, :create_interaction_response, fn _interaction, response ->
        ephemeral = 1 <<< 6

        assert response.data.content == "Your balance is 0"
        assert response.data.flags == ephemeral

        {:ok}
      end)

      Balance.main(%Interaction{
        data: %ApplicationCommandInteractionData{
          name: "balance"
        },
        user: %User{id: user_id}
      })
    end
  end
end

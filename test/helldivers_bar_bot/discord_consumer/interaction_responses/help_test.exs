defmodule HelldiversBarBot.DiscordConsumer.InteractionResponses.HelpTest do
  use ExUnit.Case
  use HelldiversBarBot.DataCase
  use Mimic

  import Bitwise

  alias HelldiversBarBot.DiscordConsumer.InteractionResponses.Help
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.ApplicationCommandInteractionData

  describe "main/1" do
    test "successfully sends help message" do
      expect(Nostrum.Api, :create_interaction_response, fn _msg, response ->
        ephemeral_setting = 1 <<< 6
        assert response.data.flags == ephemeral_setting, "message should be ephemeral"

        {:ok}
      end)

      Help.main(%Interaction{
        data: %ApplicationCommandInteractionData{name: "help"}
      })
    end

    test "fails when create_interaction_response fails" do
      expect(Nostrum.Api, :create_interaction_response, fn _msg, _response ->
        {:error, "some error"}
      end)

      assert {:error, "some error"} = Help.main(%Interaction{
        data: %ApplicationCommandInteractionData{name: "help"}
      })
    end
  end
end

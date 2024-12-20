defmodule HelldiversBarBot.DiscordConsumerTest do
  use HelldiversBarBot.DataCase
  use Mimic

  alias HelldiversBarBot.DiscordConsumer
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.User
  alias Nostrum.Struct.WSState

  describe "handle_event/1" do
    test "balance interaction returns balance" do
      expect(Nostrum.Api, :create_interaction_response, fn _msg, _response -> {:ok} end)

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
  end
end

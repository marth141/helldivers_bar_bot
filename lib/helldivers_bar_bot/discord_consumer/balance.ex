defmodule HelldiversBarBot.DiscordConsumer.Balance do
  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Guild.Member
  alias Nostrum.Struct.Interaction

  def main(
        %Interaction{
          data: %ApplicationCommandInteractionData{name: "balance"},
          member: %Member{
            user_id: user_id
          }
        } = msg
      ) do
    {:ok, %Helldiver{wallet: wallet}} = FindOrCreateHelldiver.main(user_id)

    response = %{
      # ChannelMessageWithSource
      type: 4,
      data: %{
        content: "Your balance is #{wallet}"
      }
    }

    Api.create_interaction_response(msg, response)
  end
end

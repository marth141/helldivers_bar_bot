defmodule HelldiversBarBot.DiscordConsumer.Interactions.Balance do
  @moduledoc """
  Handles checking a Helldiver's wallet balance on Bot Application Command Interaction.
  """

  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Guild.Member
  alias Nostrum.Struct.Interaction

  @spec main(%Interaction{}) :: :ok | {:error, any()}
  def main(
        %Interaction{
          data: %ApplicationCommandInteractionData{name: "balance"},
          member: %Member{
            user_id: user_id
          }
        } = msg
      ) do
    with {:ok, %Helldiver{wallet: wallet}} <- FindOrCreateHelldiver.main(user_id) do
      response = %{
        type: 4,
        data: %{
          content: "Your balance is #{wallet}"
        }
      }

      Api.create_interaction_response(msg, response)
      :ok
    else
      {:error, message} -> {:error, message}
    end
  end
end

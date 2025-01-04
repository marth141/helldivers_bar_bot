defmodule HelldiversBarBot.DiscordConsumer.InteractionResponses.Balance do
  @moduledoc """
  Handles checking a Helldiver's wallet balance on Bot Application Command Interaction.
  """
  import Bitwise

  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.User

  # Adds flag from discord API which is a bitfield.
  # Bitfields can be easily done with Bitwise like here.
  # Since this command should be ephemeral, according to the docs, the flag is 1 << 6.
  # This should evaluate to the integer 64, but accurately reflects the docs here.
  #
  # https://discord.com/developers/docs/resources/message#message-object-message-flags
  @ephemeral_flag 1 <<< 6

  @spec main(Interaction.t()) :: {:ok} | {:error, term()}
  def main(
        %Interaction{
          data: %ApplicationCommandInteractionData{name: "balance"},
          user: %User{
            id: user_id
          }
        } = msg
      ) do
    case FindOrCreateHelldiver.main(user_id) do
      {:ok, %Helldiver{wallet: wallet}} ->
        response = %{
          type: 4,
          data: %{
            content: "Your balance is #{wallet}",
            flags: @ephemeral_flag
          }
        }

        Api.create_interaction_response(msg, response)

      {:error, message} ->
        {:error, message}
    end
  end
end

defmodule HelldiversBarBot.DiscordConsumer.Interactions.Balance do
  @moduledoc """
  Handles checking a Helldiver's wallet balance on Bot Application Command Interaction.
  """

  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.User

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
            content: "Your balance is #{wallet}"
          }
        }

        Api.create_interaction_response(msg, response)

      {:error, message} ->
        {:error, message}
    end
  end
end

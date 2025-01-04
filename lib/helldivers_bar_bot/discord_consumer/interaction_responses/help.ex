defmodule HelldiversBarBot.DiscordConsumer.InteractionResponses.Help do
  @moduledoc """
  Handles checking a Helldiver's wallet balance on Bot Application Command Interaction.
  """

  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction

  @spec main(Interaction.t()) :: {:ok} | {:error, term()}
  def main(
        %Interaction{
          data: %ApplicationCommandInteractionData{name: "help"}
        } = msg
      ) do
    response = %{
      type: 4,
      data: %{
        content: """
        Hello there, I am your bartender. Here is a list of some commands you can issue me.

        /balance - Gives the balance of a Helldiver's wallet
        /buy_drink - Buys a drink for a Helldiver
        /help - Displays this help message

        Every message you send in the server will result in being rewarded with 0.25 bar credits.
        These can be used to purchase drinks.
        """
      }
    }

    Api.create_interaction_response(msg, response)
  end
end

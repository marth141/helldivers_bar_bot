defmodule HelldiversBarBot.DiscordConsumer.BuyDrink do
  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction
  alias HelldiversBarBot.Helldivers

  def main(
        %Interaction{
          data: %ApplicationCommandInteractionData{
            name: "buy_drink",
            options: [
              %{name: "drink", value: drink},
              %{name: "user", value: user_id}
            ]
          }
        } = msg
      ) do
    response = %{
      # ChannelMessageWithSource
      type: 4,
      data: %{
        content: "You bought a #{drink} for <@#{user_id}>"
      }
    }

    with {:ok, %Helldiver{wallet: wallet, messages_sent: messages_sent} = helldiver} <-
           FindOrCreateHelldiver.main(user_id) do
      Helldivers.update_helldiver(helldiver, %{
        "messages_sent" => messages_sent + 1,
        "wallet" => Decimal.sub(wallet, "0.25")
      })
    else
      {:error, reason} -> {:error, reason}
    end

    Api.create_interaction_response(msg, response)
  end
end

defmodule HelldiversBarBot.DiscordConsumer.Interactions.BuyDrink do
  @moduledoc """
  Handles the buying of a drink on Bot Application Command Interaction
  """

  alias HelldiversBarBot.Drinks
  alias HelldiversBarBot.Drinks.Drink
  alias Nostrum.Struct.User
  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction
  alias HelldiversBarBot.Helldivers

  @spec main(%Interaction{}) :: :ok | {:error, any()}
  def main(
        %Interaction{
          data: %ApplicationCommandInteractionData{
            name: "buy_drink",
            options: [
              %{name: "drink", value: drink},
              %{name: "user", value: receiver_discord_id}
            ]
          },
          user: %User{id: buyer_discord_id}
        } = msg
      ) do
    %Drink{description: description} = Drinks.get_drink_by_name!(drink)

    response = %{
      type: 4,
      data: %{
        content: """
        You bought a #{drink} for <@#{receiver_discord_id}>

        #{drink} is a #{description}
        """
      }
    }

    with {:ok, %Helldiver{wallet: wallet, messages_sent: messages_sent} = helldiver} <-
           FindOrCreateHelldiver.main(buyer_discord_id) do
      Helldivers.update_helldiver(helldiver, %{
        "messages_sent" => messages_sent + 1,
        "wallet" => Decimal.sub(wallet, "0.25")
      })

      Api.create_interaction_response(msg, response)
      :ok
    else
      {:error, reason} -> {:error, reason}
    end
  end
end

defmodule HelldiversBarBot.DiscordConsumer.InteractionResponses.BuyDrink do
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

  @spec main(Interaction.t()) :: {:ok} | {:error, term()}
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
    %Drink{description: description, cost: cost, taste: drink_taste} =
      Drinks.get_drink_by_name!(drink)

    description = String.downcase(description)

    tastes = ["democracy", "liberty", "freedom", "patriotism", "home"]
    taste = if(is_nil(drink_taste), do: Enum.random(tastes), else: drink_taste)

    response = %{
      type: 4,
      data: %{
        content: """
        <@#{buyer_discord_id}> bought a cold #{drink} for <@#{receiver_discord_id}>

        The #{drink} is a #{description} and tastes like #{taste}!
        """
      }
    }

    case FindOrCreateHelldiver.main(buyer_discord_id) do
      {:ok, %Helldiver{wallet: wallet, messages_sent: messages_sent} = helldiver} ->
        Helldivers.update_helldiver(helldiver, %{
          "messages_sent" => messages_sent + 1,
          "wallet" => Decimal.sub(wallet, cost)
        })

        Api.create_interaction_response(msg, response)

      {:error, reason} ->
        {:error, reason}
    end
  end
end

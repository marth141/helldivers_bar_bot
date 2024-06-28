defmodule HelldiversBarBot.DiscordConsumer.BuyDrink do
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

    case Helldivers.get_helldiver_by_discord_id!(to_string(user_id)) do
      %Helldiver{wallet: wallet} = helldiver ->
        Helldivers.update_helldiver(helldiver, %{"wallet" => Decimal.sub(wallet, "0.25")})
    end

    Api.create_interaction_response(msg, response)
  end
end

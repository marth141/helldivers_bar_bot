defmodule HelldiversBarBot.DiscordConsumer do
  use Nostrum.Consumer

  alias HelldiversBarBot.DiscordConsumer.Balance
  alias HelldiversBarBot.DiscordConsumer.BuyDrink
  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.MagicEightBall
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.Message
  alias Nostrum.Struct.User
  alias Nostrum.Struct.WSState

  @spec handle_event({:MESSAGE_CREATE, Message.t(), WSState.t()}) :: any()
  def handle_event(
        {:MESSAGE_CREATE, %Message{author: %User{id: discord_user_id}, content: content} = msg,
         _ws_state}
      ) do
    content = String.downcase(content)

    case content do
      "ping!" ->
        Api.create_message(msg.channel_id, "I copy and pasted this code")

      "barkeep," <> _ ->
        phrases = MagicEightBall.phrases()

        Api.create_message(msg.channel_id, Enum.random(phrases))

      _ ->
        FindOrCreateHelldiver.main(discord_user_id)

        :ignore
    end
  end

  def handle_event(
        {:INTERACTION_CREATE,
         %Interaction{data: %ApplicationCommandInteractionData{name: "rick"}} = msg, _ws_state}
      ) do
    response = %{
      # ChannelMessageWithSource
      type: 4,
      data: %{
        content: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      }
    }

    Api.create_interaction_response(msg, response)
  end

  def handle_event(
        {:INTERACTION_CREATE,
         %Interaction{
           data: %ApplicationCommandInteractionData{name: "balance"}
         } = msg, _ws_state}
      ) do
    Balance.main(msg)
  end

  def handle_event(
        {:INTERACTION_CREATE,
         %Interaction{
           data: %ApplicationCommandInteractionData{
             name: "buy_drink"
           }
         } = msg, _ws_state}
      ) do
    BuyDrink.main(msg)
  end
end

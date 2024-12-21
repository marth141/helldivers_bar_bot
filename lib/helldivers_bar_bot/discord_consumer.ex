defmodule HelldiversBarBot.DiscordConsumer do
  @moduledoc """
  Defines a consumer for Discord messages to be handled by the bot
  """

  use Nostrum.Consumer

  alias HelldiversBarBot.DiscordConsumer.IncrementWallet
  alias HelldiversBarBot.DiscordConsumer.Interactions.Balance
  alias HelldiversBarBot.DiscordConsumer.Interactions.BuyDrink
  alias HelldiversBarBot.DiscordConsumer.Interactions.Help
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

      "whats the latest?" ->
        HelldiversBarBot.DiscordConsumer.News.main(msg)

      "what's the latest?" ->
        HelldiversBarBot.DiscordConsumer.News.main(msg)

      _ ->
        IncrementWallet.main(discord_user_id)

        :ignore
    end
  end

  @spec handle_event({:INTERACTION_CREATE, Interaction.t(), WSState.t()}) ::
          {:ok} | {:error, term()}
  def handle_event(
        {:INTERACTION_CREATE,
         %Interaction{
           data: %ApplicationCommandInteractionData{
             name: "balance"
           }
         } = msg, _ws_state}
      ) do
    Balance.main(msg)
  end

  @spec handle_event({:INTERACTION_CREATE, Interaction.t(), WSState.t()}) ::
          {:ok} | {:error, term()}
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

  @spec handle_event({:INTERACTION_CREATE, Interaction.t(), WSState.t()}) ::
          {:ok} | {:error, term()}
  def handle_event(
        {:INTERACTION_CREATE,
         %Interaction{
           data: %ApplicationCommandInteractionData{
             name: "help"
           }
         } = msg, _ws_state}
      ) do
    Help.main(msg)
  end
end

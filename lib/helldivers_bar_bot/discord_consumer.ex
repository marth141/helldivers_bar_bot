defmodule HelldiversBarBot.DiscordConsumer do
  use Nostrum.Consumer

  alias HelldiversBarBot.MagicEightBall
  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver
  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Guild.Member, as: GuildMember
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.Message
  alias Nostrum.Struct.User
  alias Nostrum.Struct.WSState

  @spec handle_event({:MESSAGE_CREATE, Message.t(), WSState.t()}) ::
          any()
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
        FindOrCreateHelldiver.call(discord_user_id)

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
           data: %ApplicationCommandInteractionData{name: "balance"},
           member: %GuildMember{
             user_id: user_id
           }
         } = msg, _ws_state}
      ) do
    %Helldiver{wallet: wallet} = Helldivers.get_helldiver!(discord_id: to_string(user_id))

    response = %{
      # ChannelMessageWithSource
      type: 4,
      data: %{
        content: "Your balance is #{wallet}"
      }
    }

    Api.create_interaction_response(msg, response)
  end

  def handle_event(
        {:INTERACTION_CREATE,
         %Interaction{
           data: %ApplicationCommandInteractionData{
             name: "buy_drink",
             options: [
               %{name: "drink", value: drink},
               %{name: "user", value: user_id}
             ]
           }
         } = msg, _ws_state}
      ) do
    response = %{
      # ChannelMessageWithSource
      type: 4,
      data: %{
        content: "You bought a #{drink} for <@#{user_id}>"
      }
    }

    Api.create_interaction_response(msg, response)
  end
end

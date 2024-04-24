defmodule HelldiversBarBot.DiscordConsumer do
  use Nostrum.Consumer
  alias HelldiversBarBot.Repo
  alias HelldiversBarBot.Helldivers.Helldiver
  alias HelldiversBarBot.Helldivers
  alias Nostrum.Api
  alias Nostrum.Struct.Interaction
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Guild.Member, as: GuildMember

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    content = String.downcase(msg.content)

    case content do
      "ping!" ->
        Api.create_message(msg.channel_id, "I copy and pasted this code")

      "bot," <> _ ->
        messages = [
          "It is certain",
          "It is decidedly so",
          "Without a doubt",
          "Yes definitely",
          "You may rely on it",
          "As I see it, yes",
          "Most likely",
          "Outlook good",
          "Yes",
          "Signs point to yes",
          "Reply hazy, try again",
          "Ask again later",
          "Better not tell you now",
          "Cannot predict now",
          "Concentrate and ask again",
          "Don't count on it",
          "My reply is no",
          "My sources say no",
          "Outlook not so good",
          "Very doubtful",
          "oh yeh baby"
        ]

        Api.create_message(msg.channel_id, Enum.random(messages))

      _ ->
        %Nostrum.Struct.Message{
          author: %Nostrum.Struct.User{
            id: discord_id
          }
        } = msg

        %Helldiver{
          messages_sent: messages_sent,
          wallet: wallet
        } = member = Helldivers.get_helldiver!(discord_id: to_string(discord_id))

        IO.inspect(member)

        member
        |> Helldiver.changeset(%{
          "messages_sent" => messages_sent + 1,
          "wallet" => Decimal.add(wallet, "0.25")
        })
        |> Repo.update!()

        :ignore
    end
  end

  def handle_event(
        {:INTERACTION_CREATE,
         %Interaction{data: %ApplicationCommandInteractionData{name: "rick"}} = msg, _ws_state}
      ) do
    IO.inspect(msg)

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
    IO.inspect(msg)

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
end

defmodule HelldiversBarBot.DiscordConsumer do
  use Nostrum.Consumer
  alias HelldiversBarBot.Repo
  alias HelldiversBarBot.Schema.Member
  alias HelldiversBarBot.Members
  alias Nostrum.Api

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    case msg.content do
      "ping!" ->
        Api.create_message(msg.channel_id, "I copy and pasted this code")

      _ ->
        %Nostrum.Struct.Message{
          author: %Nostrum.Struct.User{
            id: discord_id
          }
        } = msg

        %Member{
          messages_sent: messages_sent,
          wallet: wallet
        } = member = Members.get_member(discord_id: discord_id)

        IO.inspect(member)

        member
        |> Member.changeset(%{
          "messages_sent" => messages_sent + 1,
          "wallet" => Decimal.add(wallet, "0.25")
        })
        |> Repo.update!()

        :ignore
    end
  end
end

defmodule HelldiversBarBot.DiscordConsumer.News do
  alias Nostrum.Struct.Message

  @spec main(Message.t()) :: {:ok, Nostrum.Struct.Message.t()} | {:error, term()}
  def main(msg) do
    latest =
      Helldivers2.Api.get_news()
      |> List.last()
      |> Map.get("message")

    Nostrum.Api.create_message(msg.channel_id, latest)
  end
end

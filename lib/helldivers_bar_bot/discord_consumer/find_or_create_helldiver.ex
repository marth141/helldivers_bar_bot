defmodule HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver do
  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver

  @spec main(String.t()) :: any()
  def main(discord_user_id) do
    case Helldivers.get_helldiver_by_discord_id!(to_string(discord_user_id)) do
      # Found Helldiver
      %Helldiver{
        messages_sent: messages_sent,
        wallet: wallet
      } = helldiver ->
        Helldivers.update_helldiver(helldiver, %{
          "messages_sent" => messages_sent + 1,
          "wallet" => Decimal.add(wallet, "0.25")
        })

      # Helldiver not found
      _ ->
        Nostrum.Api.get_user!(discord_user_id)
        |> Helldivers.create_helldiver()
    end
  end
end

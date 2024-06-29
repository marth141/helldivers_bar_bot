defmodule HelldiversBarBot.DiscordConsumer.IncrementWallet do
  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver

  def main(discord_user_id) do
    {:ok, %Helldiver{wallet: wallet} = helldiver} =
      FindOrCreateHelldiver.main(discord_user_id)

    Helldivers.update_helldiver(helldiver, %{wallet: Decimal.add(wallet, "0.25")})
  end
end

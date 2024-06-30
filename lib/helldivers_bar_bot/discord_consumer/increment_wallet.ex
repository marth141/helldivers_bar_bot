defmodule HelldiversBarBot.DiscordConsumer.IncrementWallet do
  @moduledoc """
  Defines the logic for incrementing a Helldiver's wallet for server activity
  """

  alias HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver
  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver

  @spec main(String.t()) :: {:ok, Helldiver.t()} | {:error, Ecto.Changeset.t()}
  def main(discord_user_id) do
    {:ok, %Helldiver{wallet: wallet} = helldiver} =
      FindOrCreateHelldiver.main(discord_user_id)

    Helldivers.update_helldiver(helldiver, %{wallet: Decimal.add(wallet, "0.25")})
  end
end

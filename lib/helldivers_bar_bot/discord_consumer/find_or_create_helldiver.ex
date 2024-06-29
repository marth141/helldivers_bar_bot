defmodule HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver do
  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver

  @spec main(String.t()) :: {:ok, %Helldiver{}} | {:error, any()}
  def main(discord_user_id) do
    with %Helldiver{} = helldiver <-
           Helldivers.get_helldiver_by_discord_id(to_string(discord_user_id)) do
      # Found Helldiver
      {:ok, helldiver}
    else
      # Helldiver not found
      nil ->
        with {:ok, user} <- Nostrum.Api.get_user(discord_user_id) do
          Helldivers.create_helldiver(user)
        else
          {:error, message} -> {:error, message}
        end
    end
  end
end

defmodule HelldiversBarBot.DiscordConsumer.FindOrCreateHelldiver do
  @moduledoc """
  Defines logic for finding or creating a Helldiver
  """

  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver

  @spec main(String.t()) :: {:ok, Helldiver.t()} | {:error, term()}
  def main(discord_user_id) do
    case Helldivers.get_helldiver_by_discord_id(to_string(discord_user_id)) do
      # Found Helldiver
      %Helldiver{} = helldiver ->
        {:ok, helldiver}

      # Helldiver not found
      nil ->
        case Nostrum.Api.get_user(discord_user_id) do
          {:ok, user} ->
            Helldivers.create_helldiver(user)

          {:error, message} ->
            {:error, message}
        end
    end
  end
end

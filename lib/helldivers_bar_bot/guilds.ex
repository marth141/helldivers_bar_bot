defmodule HelldiversBarBot.Guilds do
  alias HelldiversBarBot.Repo
  alias HelldiversBarBot.Schema.Guild

  def list_guilds() do
    Repo.all(Guild)
  end

  def get_guild(discord_id: id) do
    Repo.get_by!(Guild, discord_id: id)
  end

  def create_guild(%Nostrum.Struct.Guild{id: discord_id, name: guild_name}) do
    %Guild{}
    |> Guild.changeset(%{discord_id: discord_id, name: guild_name})
    |> Repo.insert()
  end

  def update_guild(%Guild{} = guild, attrs) do
    guild
    |> Guild.changeset(attrs)
    |> Repo.update()
  end

  def delete_guild(%Guild{} = guild) do
    Repo.delete(guild)
  end

  def change_guild(%Guild{} = guild, attrs \\ %{}) do
    Guild.changeset(guild, attrs)
  end
end

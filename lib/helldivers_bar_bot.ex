defmodule HelldiversBarBot do
  @moduledoc """
  HelldiversBarBot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias HelldiversBarBot.Members
  alias HelldiversBarBot.Guilds

  def add_guilds() do
    Nostrum.Api.get_current_user_guilds!()
    |> Enum.each(&Guilds.create_guild(&1))
  end

  def add_members() do
    Nostrum.Api.list_guild_members!(601_449_327_591_686_186, limit: 1000)
    |> Enum.map(fn
      %Nostrum.Struct.Guild.Member{
        user_id: discord_id,
        nick: nil
      } ->
        Nostrum.Api.get_user!(discord_id)

      %Nostrum.Struct.Guild.Member{} = user ->
        user
    end)
    |> Enum.each(&Members.create_members(&1))
  end
end

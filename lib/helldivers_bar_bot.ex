defmodule HelldiversBarBot do
  @moduledoc """
  HelldiversBarBot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias HelldiversBarBot.Helldivers
  alias Nostrum.Cache.Me

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
    |> Enum.each(&Helldivers.create_helldiver(&1))
  end

  def list_commands() do
    application_id = Me.get().id
    Nostrum.Api.get_global_application_commands(application_id)
  end

  def add_command() do
    application_id = Me.get().id

    command = %{
      name: "balance",
      description: "checks wallet"
    }

    Nostrum.Api.create_global_application_command(application_id, command)
  end
end

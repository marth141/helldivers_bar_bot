defmodule HelldiversBarBot do
  @moduledoc """
  HelldiversBarBot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias HelldiversBarBot.Commands
  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Drinks
  alias Nostrum.Cache.Me

  def install(guild_id) do
    add_members(guild_id)
    add_commands()
  end

  def add_members(guild_id) do
    Nostrum.Api.list_guild_members!(guild_id, limit: 1000)
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

  def remove_command(command_id) do
    Nostrum.Api.delete_global_application_command(command_id)
  end

  def add_commands() do
    Commands.Balance.add()
    Commands.BuyDrink.add()
    Commands.Help.add()
  end

  def add_drinks_from_csv() do
    File.stream!("drinks.csv")
    |> CSV.decode(headers: true)
    |> Enum.map(fn {:ok, drink} -> drink end)
    |> Enum.each(fn drink ->
      Drinks.create_drink(drink)
    end)
  end
end

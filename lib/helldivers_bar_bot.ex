defmodule HelldiversBarBot do
  @moduledoc """
  HelldiversBarBot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias HelldiversBarBot.Commands.BalanceCommnd
  alias HelldiversBarBot.Helldivers
  alias Nostrum.Cache.Me

  def install(guild_id) do
    add_members(guild_id)
    add_balance_command()
    add_buy_drink_command()
    add_drinks()
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

  def add_balance_command() do
    BalanceCommnd.add()
  end

  def add_buy_drink_command() do
    application_id = Me.get().id

    drinks =
      HelldiversBarBot.Drinks.list_drinks()
      |> Enum.map(fn %{name: name} -> %{name: name, value: name} end)

    command = %{
      name: "buy_drink",
      description: "buys a drink",
      options: [
        %{
          type: 3,
          name: "drink",
          description: "specify the drink to buy",
          choices: drinks
        },
        %{type: 6, name: "user", description: "specify the user to give the drink to"}
      ]
    }

    Nostrum.Api.create_global_application_command(application_id, command)
  end

  def add_drinks() do
    File.stream!("drinks.csv")
    |> CSV.decode(headers: true)
    |> Enum.map(fn {:ok, drink} -> drink end)
    |> Enum.each(fn drink ->
      HelldiversBarBot.Drinks.create_drink(drink)
    end)
  end
end

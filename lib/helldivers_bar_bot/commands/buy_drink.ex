defmodule HelldiversBarBot.Commands.BuyDrink do
  @moduledoc """
  Contains the logic for adding buy_drink command to the Bot's Application Commands
  """

  alias Nostrum.Cache.Me

  def add() do
    application_id = Me.get().id

    Nostrum.Api.create_global_application_command(application_id, command())
  end

  defp command() do
    drinks =
      HelldiversBarBot.Drinks.list_drinks()
      |> Enum.map(fn %{name: name} -> %{name: name, value: name} end)

    %{
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
  end
end

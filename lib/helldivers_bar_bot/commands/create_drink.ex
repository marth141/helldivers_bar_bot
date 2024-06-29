defmodule HelldiversBarBot.Commands.CreateDrink do
  @moduledoc """
  Contains the logic for adding create_drink command to the Bot's Application Commands
  """

  alias Nostrum.Cache.Me

  def add() do
    application_id = Me.get().id

    Nostrum.Api.create_global_application_command(application_id, command())
  end

  defp command() do
    %{
      name: "add_drink",
      description: "adds a drink",
      options: [
        %{type: 3, name: "name", description: "name the drink"},
        %{type: 3, name: "description", description: "describe the drink"},
        %{type: 3, name: "cost", description: "how much is the drink?"}
      ]
    }
  end
end

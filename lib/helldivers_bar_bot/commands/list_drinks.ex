defmodule HelldiversBarBot.Commands.ListDrink do
  @moduledoc """
  Contains the logic for adding list_drink command to the Bot's Application Commands
  """

  alias Nostrum.Cache.Me

  @spec add() :: {:ok, map()} | {:error, term()}
  def add() do
    application_id = Me.get().id

    Nostrum.Api.create_global_application_command(application_id, command())
  end

  defp command() do
    %{
      name: "list_drinks",
      description: "lists drinks"
    }
  end
end

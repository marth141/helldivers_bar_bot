defmodule HelldiversBarBot.Commands.Balance do
  @moduledoc """
  Contains the logic for adding balance command to the Bot's Application Commands
  """

  alias Nostrum.Cache.Me

  @spec add() :: {:ok, map()} | {:error, term()}
  def add() do
    application_id = Me.get().id

    Nostrum.Api.create_global_application_command(application_id, command())
  end

  defp command() do
    %{
      name: "balance",
      description: "checks wallet"
    }
  end
end

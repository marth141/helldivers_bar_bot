defmodule HelldiversBarBot.Commands.Balance do
  alias Nostrum.Cache.Me

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

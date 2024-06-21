defmodule HelldiversBarBot.HelldiversFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelldiversBarBot.Helldivers` context.
  """

  @doc """
  Generate a helldiver.
  """
  def helldiver_fixture(attrs \\ %{}) do
    {:ok, helldiver} =
      attrs
      |> Enum.into(%{
        discord_id: "some discord_id",
        messages_sent: 42,
        name: "some name",
        wallet: "120.5"
      })
      |> HelldiversBarBot.Helldivers.create_helldiver()

    helldiver
  end
end

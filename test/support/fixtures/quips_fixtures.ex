defmodule HelldiversBarBot.QuipsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelldiversBarBot.Quips` context.
  """

  @doc """
  Generate a quip.
  """
  def quip_fixture(attrs \\ %{}) do
    {:ok, quip} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> HelldiversBarBot.Quips.create_quip()

    quip
  end
end

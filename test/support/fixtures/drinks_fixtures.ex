defmodule HelldiversBarBot.DrinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelldiversBarBot.Drinks` context.
  """

  @doc """
  Generate a drink.
  """
  def drink_fixture(attrs \\ %{}) do
    {:ok, drink} =
      attrs
      |> Enum.into(%{
        cost: 42,
        description: "some description",
        name: "some name"
      })
      |> HelldiversBarBot.Drinks.create_drink()

    drink
  end
end

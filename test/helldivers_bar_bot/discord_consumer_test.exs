defmodule HelldiversBarBot.DiscordConsumerTest do
  use HelldiversBarBot.DataCase

  alias HelldiversBarBot.Drinks
  alias HelldiversBarBot.Drinks.Drink

  describe "Listing Drinks" do
    setup do
      %{
        name: "some drink",
        description: "some description",
        cost: Decimal.new("0.25")
      }
      |> Drinks.create_drink()

      :ok
    end

    test "Some test" do
      Drinks.list_drinks()
    end
  end
end

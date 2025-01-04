defmodule HelldiversBarBot.DiscordConsumer.InteractionResponses.ListDrinksTest do
  use ExUnit.Case
  use HelldiversBarBot.DataCase
  use Mimic

  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction

  describe "main/1" do
    setup do
      HelldiversBarBot.Drinks.create_drink(%{
        name: "beer",
        description: "your average beer",
        cost: Decimal.new("1.00")
      })

      HelldiversBarBot.Drinks.create_drink(%{
        name: "ale",
        description: "your average ale",
        cost: Decimal.new("1.50")
      })

      %{}
    end

    test "successfully lists drinks" do
      expect(Nostrum.Api, :create_interaction_response, fn _msg, _response ->
        {:ok}
      end)

      HelldiversBarBot.DiscordConsumer.InteractionResponses.ListDrinks.main(%Interaction{
        data: %ApplicationCommandInteractionData{
          name: "list_drinks"
        }
      })
    end
  end
end

defmodule HelldiversBarBot.DrinksTest do
  use HelldiversBarBot.DataCase

  alias HelldiversBarBot.Drinks

  describe "drinks" do
    alias HelldiversBarBot.Drinks.Drink

    import HelldiversBarBot.DrinksFixtures

    @invalid_attrs %{name: nil, description: nil, cost: nil}

    test "list_drinks/0 returns all drinks" do
      drink = drink_fixture()
      assert Drinks.list_drinks() == [drink]
    end

    test "get_drink!/1 returns the drink with given id" do
      drink = drink_fixture()
      assert Drinks.get_drink!(drink.id) == drink
    end

    test "create_drink/1 with valid data creates a drink" do
      valid_attrs = %{name: "some name", description: "some description", cost: 42}

      assert {:ok, %Drink{} = drink} = Drinks.create_drink(valid_attrs)
      assert drink.name == "some name"
      assert drink.description == "some description"
      assert drink.cost == 42
    end

    test "create_drink/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drinks.create_drink(@invalid_attrs)
    end

    test "update_drink/2 with valid data updates the drink" do
      drink = drink_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        cost: 43
      }

      assert {:ok, %Drink{} = drink} = Drinks.update_drink(drink, update_attrs)
      assert drink.name == "some updated name"
      assert drink.description == "some updated description"
      assert drink.cost == 43
    end

    test "update_drink/2 with invalid data returns error changeset" do
      drink = drink_fixture()
      assert {:error, %Ecto.Changeset{}} = Drinks.update_drink(drink, @invalid_attrs)
      assert drink == Drinks.get_drink!(drink.id)
    end

    test "delete_drink/1 deletes the drink" do
      drink = drink_fixture()
      assert {:ok, %Drink{}} = Drinks.delete_drink(drink)
      assert_raise Ecto.NoResultsError, fn -> Drinks.get_drink!(drink.id) end
    end

    test "change_drink/1 returns a drink changeset" do
      drink = drink_fixture()
      assert %Ecto.Changeset{} = Drinks.change_drink(drink)
    end
  end
end

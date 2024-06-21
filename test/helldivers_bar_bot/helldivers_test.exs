defmodule HelldiversBarBot.HelldiversTest do
  use HelldiversBarBot.DataCase

  alias HelldiversBarBot.Helldivers

  describe "Helldivers" do
    alias HelldiversBarBot.Helldivers.Helldiver

    import HelldiversBarBot.HelldiversFixtures

    @invalid_attrs %{name: nil, discord_id: nil, messages_sent: nil, wallet: nil}

    test "list_helldivers/0 returns all helldivers" do
      helldiver = helldiver_fixture()
      assert Helldivers.list_helldivers() == [helldiver]
    end

    test "get_helldiver!/1 returns the helldiver with given id" do
      helldiver = helldiver_fixture()
      assert Helldivers.get_helldiver!(helldiver.id) == helldiver
    end

    test "create_helldiver/1 with valid data creates a helldiver" do
      valid_attrs = %{
        name: "some name",
        discord_id: "some discord_id",
        messages_sent: 42,
        wallet: "120.5"
      }

      assert {:ok, %Helldiver{} = helldiver} = Helldivers.create_helldiver(valid_attrs)
      assert helldiver.name == "some name"
      assert helldiver.discord_id == "some discord_id"
      assert helldiver.messages_sent == 42
      assert helldiver.wallet == Decimal.new("120.5")
    end

    test "create_helldiver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Helldivers.create_helldiver(@invalid_attrs)
    end

    test "update_helldiver/2 with valid data updates the helldiver" do
      helldiver = helldiver_fixture()

      update_attrs = %{
        name: "some updated name",
        discord_id: "some updated discord_id",
        messages_sent: 43,
        wallet: "456.7"
      }

      assert {:ok, %Helldiver{} = helldiver} = Helldivers.update_helldiver(helldiver, update_attrs)
      assert helldiver.name == "some updated name"
      assert helldiver.discord_id == "some updated discord_id"
      assert helldiver.messages_sent == 43
      assert helldiver.wallet == Decimal.new("456.7")
    end

    test "update_helldiver/2 with invalid data returns error changeset" do
      helldiver = helldiver_fixture()
      assert {:error, %Ecto.Changeset{}} = Helldivers.update_helldiver(helldiver, @invalid_attrs)
      assert helldiver == Helldivers.get_helldiver!(helldiver.id)
    end

    test "delete_helldiver/1 deletes the helldiver" do
      helldiver = helldiver_fixture()
      assert {:ok, %Helldiver{}} = Helldivers.delete_helldiver(helldiver)
      assert_raise Ecto.NoResultsError, fn -> Helldivers.get_helldiver!(helldiver.id) end
    end

    test "change_helldiver/1 returns a helldiver changeset" do
      helldiver = helldiver_fixture()
      assert %Ecto.Changeset{} = Helldivers.change_helldiver(helldiver)
    end
  end
end

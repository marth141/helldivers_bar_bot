defmodule HelldiversBarBot.QuipsTest do
  use HelldiversBarBot.DataCase

  alias HelldiversBarBot.Quips

  describe "quips" do
    alias HelldiversBarBot.Quips.Quip

    import HelldiversBarBot.QuipsFixtures

    @invalid_attrs %{text: nil}

    test "list_quips/0 returns all quips" do
      quip = quip_fixture()
      assert Quips.list_quips() == [quip]
    end

    test "get_quip!/1 returns the quip with given id" do
      quip = quip_fixture()
      assert Quips.get_quip!(quip.id) == quip
    end

    test "create_quip/1 with valid data creates a quip" do
      valid_attrs = %{text: "some text"}

      assert {:ok, %Quip{} = quip} = Quips.create_quip(valid_attrs)
      assert quip.text == "some text"
    end

    test "create_quip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quips.create_quip(@invalid_attrs)
    end

    test "update_quip/2 with valid data updates the quip" do
      quip = quip_fixture()
      update_attrs = %{text: "some updated text"}

      assert {:ok, %Quip{} = quip} = Quips.update_quip(quip, update_attrs)
      assert quip.text == "some updated text"
    end

    test "update_quip/2 with invalid data returns error changeset" do
      quip = quip_fixture()
      assert {:error, %Ecto.Changeset{}} = Quips.update_quip(quip, @invalid_attrs)
      assert quip == Quips.get_quip!(quip.id)
    end

    test "delete_quip/1 deletes the quip" do
      quip = quip_fixture()
      assert {:ok, %Quip{}} = Quips.delete_quip(quip)
      assert_raise Ecto.NoResultsError, fn -> Quips.get_quip!(quip.id) end
    end

    test "change_quip/1 returns a quip changeset" do
      quip = quip_fixture()
      assert %Ecto.Changeset{} = Quips.change_quip(quip)
    end
  end
end

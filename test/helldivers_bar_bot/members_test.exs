defmodule HelldiversBarBot.MembersTest do
  use HelldiversBarBot.DataCase

  alias HelldiversBarBot.Members

  describe "members" do
    alias HelldiversBarBot.Members.Member

    import HelldiversBarBot.MembersFixtures

    @invalid_attrs %{name: nil, discord_id: nil, messages_sent: nil, wallet: nil}

    test "list_members/0 returns all members" do
      member = member_fixture()
      assert Members.list_members() == [member]
    end

    test "get_member!/1 returns the member with given id" do
      member = member_fixture()
      assert Members.get_member!(member.id) == member
    end

    test "create_member/1 with valid data creates a member" do
      valid_attrs = %{
        name: "some name",
        discord_id: "some discord_id",
        messages_sent: 42,
        wallet: "120.5"
      }

      assert {:ok, %Member{} = member} = Members.create_member(valid_attrs)
      assert member.name == "some name"
      assert member.discord_id == "some discord_id"
      assert member.messages_sent == 42
      assert member.wallet == Decimal.new("120.5")
    end

    test "create_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Members.create_member(@invalid_attrs)
    end

    test "update_member/2 with valid data updates the member" do
      member = member_fixture()

      update_attrs = %{
        name: "some updated name",
        discord_id: "some updated discord_id",
        messages_sent: 43,
        wallet: "456.7"
      }

      assert {:ok, %Member{} = member} = Members.update_member(member, update_attrs)
      assert member.name == "some updated name"
      assert member.discord_id == "some updated discord_id"
      assert member.messages_sent == 43
      assert member.wallet == Decimal.new("456.7")
    end

    test "update_member/2 with invalid data returns error changeset" do
      member = member_fixture()
      assert {:error, %Ecto.Changeset{}} = Members.update_member(member, @invalid_attrs)
      assert member == Members.get_member!(member.id)
    end

    test "delete_member/1 deletes the member" do
      member = member_fixture()
      assert {:ok, %Member{}} = Members.delete_member(member)
      assert_raise Ecto.NoResultsError, fn -> Members.get_member!(member.id) end
    end

    test "change_member/1 returns a member changeset" do
      member = member_fixture()
      assert %Ecto.Changeset{} = Members.change_member(member)
    end
  end
end

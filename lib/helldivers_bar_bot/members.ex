defmodule HelldiversBarBot.Members do
  alias HelldiversBarBot.Repo
  alias HelldiversBarBot.Schema.Member

  def list_members() do
    Repo.all(Member)
  end

  def get_member(discord_id: id) do
    Repo.get_by!(Member, discord_id: id)
  end

  def create_members(%Nostrum.Struct.User{id: discord_id, username: name}) do
    %Member{}
    |> Member.changeset(%{discord_id: discord_id, name: name})
    |> Repo.insert()
  end

  def create_members(%Nostrum.Struct.Guild.Member{user_id: discord_id, nick: name}) do
    %Member{}
    |> Member.changeset(%{discord_id: discord_id, name: name})
    |> Repo.insert()
  end

  def update_members(%Member{} = member, attrs \\ %{}) do
    member
    |> Member.changeset(attrs)
    |> Repo.update()
  end

  def delete_member(%Member{} = member) do
    Repo.delete(member)
  end

  def change_member(%Member{} = member, attrs \\ %{}) do
    Member.changeset(member, attrs)
  end
end

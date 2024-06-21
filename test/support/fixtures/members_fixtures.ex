defmodule HelldiversBarBot.MembersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelldiversBarBot.Members` context.
  """

  @doc """
  Generate a member.
  """
  def member_fixture(attrs \\ %{}) do
    {:ok, member} =
      attrs
      |> Enum.into(%{
        discord_id: "some discord_id",
        messages_sent: 42,
        name: "some name",
        wallet: "120.5"
      })
      |> HelldiversBarBot.Members.create_member()

    member
  end
end

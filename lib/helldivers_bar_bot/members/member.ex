defmodule HelldiversBarBot.Members.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :name, :string
    field :discord_id, :string
    field :messages_sent, :integer
    field :wallet, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:discord_id, :name, :messages_sent, :wallet])
    |> validate_required([:discord_id, :name, :messages_sent, :wallet])
  end
end

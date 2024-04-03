defmodule HelldiversBarBot.Schema.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :discord_id, :integer
    field :name, :string
    field :messages_sent, :integer, default: 0
    field :wallet, :decimal, default: 0
  end

  def changeset(member, attrs) do
    member
    |> cast(attrs, [:discord_id, :name, :messages_sent, :wallet])
    |> validate_required([:discord_id])
    |> unique_constraint([:discord_id])
  end
end

defmodule HelldiversBarBot.Helldivers.Helldiver do
  use Ecto.Schema
  import Ecto.Changeset

  schema "helldivers" do
    field :name, :string
    field :discord_id, :string
    field :messages_sent, :integer, default: 0
    field :wallet, :decimal, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:discord_id, :name, :messages_sent, :wallet])
    |> validate_required([:discord_id])
  end
end

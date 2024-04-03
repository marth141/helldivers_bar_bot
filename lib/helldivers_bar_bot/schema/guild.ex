defmodule HelldiversBarBot.Schema.Guild do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guilds" do
    field :discord_id, :integer
    field :name, :string
  end

  def changeset(guild, attrs) do
    guild
    |> cast(attrs, [:discord_id, :name])
    |> validate_required([:discord_id, :name])
    |> unique_constraint([:discord_id])
  end
end

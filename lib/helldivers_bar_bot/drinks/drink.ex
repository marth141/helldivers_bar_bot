defmodule HelldiversBarBot.Drinks.Drink do
  use Ecto.Schema
  import Ecto.Changeset

  schema "drinks" do
    field :name, :string
    field :description, :string
    field :cost, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(drink, attrs) do
    drink
    |> cast(attrs, [:name, :cost, :description])
    |> validate_required([:name, :cost, :description])
  end
end

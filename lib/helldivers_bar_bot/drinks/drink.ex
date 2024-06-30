defmodule HelldiversBarBot.Drinks.Drink do
  @moduledoc """
  Defines a drink for a Helldiver to purchase for another Helldiver
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t(),
          description: String.t(),
          cost: Decimal.t()
        }

  schema "drinks" do
    field :name, :string
    field :description, :string
    field :cost, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(drink, attrs) do
    drink
    |> cast(attrs, [:name, :cost, :description])
    |> validate_required([:name, :cost, :description])
  end
end

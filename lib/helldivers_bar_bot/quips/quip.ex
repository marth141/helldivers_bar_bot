defmodule HelldiversBarBot.Quips.Quip do
  @moduledoc """
  Defines schema for a Quip which would be a witty line of dialogue
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "quips" do
    field :text, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quip, attrs) do
    quip
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end

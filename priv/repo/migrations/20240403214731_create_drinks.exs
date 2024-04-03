defmodule HelldiversBarBot.Repo.Migrations.CreateDrinks do
  use Ecto.Migration

  def change do
    create table(:drinks) do
      add :name, :string
      add :cost, :integer
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end

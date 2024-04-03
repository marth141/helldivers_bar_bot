defmodule HelldiversBarBot.Repo.Migrations.AddDrinksTable do
  use Ecto.Migration

  def change do
    create table(:drinks) do
      add :name, :string
      add :cost, :integer
      add :description, :string
    end
  end
end

defmodule HelldiversBarBot.Repo.Migrations.AddTasteColumnToDrinksTable do
  use Ecto.Migration

  def change do
    alter table(:drinks) do
      add :taste, :string
    end
  end
end

defmodule HelldiversBarBot.Repo.Migrations.CreateQuips do
  use Ecto.Migration

  def change do
    create table(:quips) do
      add :text, :text

      timestamps(type: :utc_datetime)
    end
  end
end

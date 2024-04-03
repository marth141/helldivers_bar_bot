defmodule HelldiversBarBot.Repo.Migrations.AddQuipsTable do
  use Ecto.Migration

  def change do
    create table(:quips) do
      add :text, :text
    end
  end
end

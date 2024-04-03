defmodule HelldiversBarBot.Repo.Migrations.AddGuildsTable do
  use Ecto.Migration

  def change do
    create table(:guilds) do
      add :discord_id, :bigint
      add :name, :string
    end

    create unique_index(:guilds, [:discord_id])
  end
end

defmodule HelldiversBarBot.Repo.Migrations.AddMembersTable do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :discord_id, :bigint
      add :name, :string
      add :messages_sent, :bigint
      add :wallet, :decimal
    end

    create unique_index(:members, [:discord_id])
  end
end

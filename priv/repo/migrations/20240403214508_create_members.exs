defmodule HelldiversBarBot.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :discord_id, :string
      add :name, :string
      add :messages_sent, :integer
      add :wallet, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end

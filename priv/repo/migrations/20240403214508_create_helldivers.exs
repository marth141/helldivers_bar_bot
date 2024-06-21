defmodule HelldiversBarBot.Repo.Migrations.CreateHelldivers do
  use Ecto.Migration

  def change do
    create table(:helldivers) do
      add :discord_id, :string
      add :name, :string
      add :messages_sent, :integer
      add :wallet, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end

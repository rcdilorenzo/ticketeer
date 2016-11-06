defmodule Ticketeer.Repo.Migrations.CreateChildren do
  use Ecto.Migration

  def change do
    create table(:children) do
      add :name,       :string, null: false
      add :identifier, :string, null: false

      timestamps
    end
  end
end

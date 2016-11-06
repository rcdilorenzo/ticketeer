defmodule Ticketeer.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :title, :string, null: false
      add :notes, :string

      add :value,           :integer, default: 0
      add :value_remaining, :integer, default: 0

      timestamps
    end
  end
end

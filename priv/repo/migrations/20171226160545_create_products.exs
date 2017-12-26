defmodule Ticketeer.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :amount, :integer
      add :description, :string

      timestamps()
    end

  end
end

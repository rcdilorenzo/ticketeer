defmodule Ticketeer.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :amount, :integer
      add :description, :string
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end

    create index(:entries, [:student_id])
  end
end

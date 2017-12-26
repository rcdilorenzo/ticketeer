defmodule Ticketeer.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string

      timestamps()
    end

  end
end

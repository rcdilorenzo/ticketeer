defmodule Ticketeer.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :name,            :string, null: false
      add :username,        :string, null: false
      add :hashed_password, :string, null: false

      timestamps
    end
  end
end

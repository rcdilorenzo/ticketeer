defmodule Ticketeer.People.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ticketeer.People.Student


  schema "students" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Student{} = student, attrs) do
    student
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

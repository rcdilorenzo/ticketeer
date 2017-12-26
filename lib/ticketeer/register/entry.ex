defmodule Ticketeer.Register.Entry do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ticketeer.Register.Entry


  schema "entries" do
    field :amount, :integer
    field :description, :string

    belongs_to :student, Ticketeer.People.Student

    timestamps()
  end

  @doc false
  def changeset(%Entry{} = entry, attrs) do
    entry
    |> cast(attrs, [:amount, :description, :student_id])
    |> validate_required([:amount, :description, :student_id])
    |> cast_assoc(:student)
  end
end

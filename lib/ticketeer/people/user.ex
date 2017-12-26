defmodule Ticketeer.People.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ticketeer.People.User


  schema "users" do
    field :email, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
  end
end

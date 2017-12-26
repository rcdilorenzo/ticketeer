defmodule Ticketeer.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ticketeer.Store.Product

  schema "products" do
    field :amount, :integer
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:amount, :description])
    |> validate_required([:amount, :description])
  end
end

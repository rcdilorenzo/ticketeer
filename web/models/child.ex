defmodule Ticketeer.Child do
  use Ticketeer.Web, :model

  @required [:name]
  @optional []
  @allowed (@required ++ @optional)

  schema "children" do
    field :name
    field :identifier

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @allowed)
    |> validate_required(@required)
    |> set_default_identifier
  end

  def set_default_identifier(changeset) do
    case fetch_field(changeset, :identifier) do
      {_, nil} ->
        put_change(changeset, :identifier, UUID.uuid4())
      _ ->
        changeset
    end
  end
end

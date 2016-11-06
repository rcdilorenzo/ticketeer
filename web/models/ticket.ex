defmodule Ticketeer.Ticket do
  use Ticketeer.Web, :model

  @required [:title, :value]
  @optional [:notes]
  @allowed (@required ++ @optional)

  schema "tickets" do
    field :title
    field :notes
    field :value,           :integer
    field :value_remaining, :integer

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @allowed)
    |> validate_required(@required)
    |> default_value_remaining
  end

  def default_value_remaining(changeset) do
    case fetch_change(changeset, :value) do
      {:ok, value} ->
        put_change(changeset, :value_remaining, value)
      :error ->
        changeset
    end
  end
end

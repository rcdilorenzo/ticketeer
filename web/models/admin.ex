defmodule Ticketeer.Admin do
  use Ticketeer.Web, :model

  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  @required [:name, :username]
  @optional [:password]
  @allowed (@required ++ @optional)

  schema "admins" do
    field :name
    field :username

    field :password, :string, virtual: true
    field :hashed_password

    timestamps
  end

  def changeset(model, params \\ :empty) do
    # TODO: Perhaps worth it to have two different
    # changesets to not accidentally allow password
    # field to be set

    model
    |> cast(params, @allowed)
    |> validate_required(@required)
    |> hash_password
  end
end

defmodule AdminTest do
  use Ticketeer.ModelCase

  alias Ticketeer.Admin

  test "hashing password" do
    initial = %Admin{name: "Jim's Father", username: "jim.father"}
    changeset = Admin.changeset(initial, %{password: "supersecret"})
    assert changeset.valid?
    refute fetch_change(changeset, :hashed_password) == :error

    admin = Repo.insert!(changeset)
    assert admin.id
    assert admin.hashed_password
  end
end

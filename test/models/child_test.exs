defmodule ChildTest do
  use Ticketeer.ModelCase

  alias Ticketeer.Child

  test "auto-generating identifier" do
    changeset = Child.changeset(%Child{}, %{name: "Jim"})
    assert changeset.valid?
    refute fetch_change(changeset, :identifier) == :error

    child = Repo.insert!(changeset)
    assert child.id
    assert child.name
  end
end

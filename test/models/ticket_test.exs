defmodule TicketTest do
  use Ticketeer.ModelCase

  alias Ticketeer.Ticket

  test "creating a simple changeset sets value remaining" do
    initial = %Ticket{
      title: "Started Work Early",
      notes: "Good job!",
    }
    changeset = Ticket.changeset(initial, %{"value" => 1})
    assert changeset.valid?
    assert fetch_change(changeset, :value_remaining) == {:ok, 1}

    ticket = Repo.insert!(changeset)
    assert ticket.id
    assert ticket.inserted_at
    assert ticket.value_remaining == 1
  end
end

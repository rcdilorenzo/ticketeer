defmodule TicketeerWeb.Api.EntryView do
  use TicketeerWeb, :view

  alias TicketeerWeb.EntryView, as: EV
  import Phoenix.HTML, only: [safe_to_string: 1]

  def render("index.json", %{conn: conn, student: student, entries: entries, page: page}) do
    entries = Enum.map(entries, fn entry ->
      render("show.json", %{conn: conn, student: student, entry: entry})[:entry]
    end)
    %{page: page, student_id: student.id, entries: entries}
  end

  def render("show.json", %{conn: conn, student: student, entry: entry}) do
    attrs = Map.take(entry, [:id, :description, :amount])
    |> Map.put(:inserted_at, EV.tx(entry.inserted_at))
    |> Map.put(:links, %{
         edit: student_entry_path(conn, :edit, student, entry),
         delete: student_entry_path(conn, :delete, student, entry)
       })

    %{student_id: student.id, entry: attrs}
  end
end

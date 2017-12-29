defmodule TicketeerWeb.Api.EntryController do
  use TicketeerWeb, :controller

  alias Ticketeer.Register
  alias Ticketeer.Register.Entry
  alias Ticketeer.People.Student

  plug :load_resource, model: Student, id_name: "student_id", persisted: true

  def index(conn, params) do
    page_opts = [page: Map.get(params, "page", 1)]
    page = Register.list_entries(student(), :paginated, page_opts)

    render(conn, "index.json",
      student: student(),
      entries: page.entries,
      page: Map.take(page, [:page_number, :page_size, :total_pages, :total_entries])
    )
  end
end

defmodule TicketeerWeb.EntryController do
  use TicketeerWeb, :controller

  alias Ticketeer.Register
  alias Ticketeer.Register.Entry
  alias Ticketeer.People.Student

  plug :load_resource, model: Student, id_name: "student_id", persisted: true

  def index(conn, _params) do
    IO.inspect conn.assigns
    entries = Register.list_entries(student())
    render(conn, "index.html", student: student(), entries: entries)
  end

  def new(conn, _params) do
    changeset = Register.change_entry(%Entry{student_id: student().id})
    render(conn, "new.html", student: student(), changeset: changeset)
  end

  def create(conn, %{"entry" => raw_params}) do
    entry_params = Map.put(raw_params, "student_id", student().id)
    case Register.create_entry(entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: student_entry_path(conn, :index, student()))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", student: student(), changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    entry = Register.get_entry!(student(), id)
    changeset = Register.change_entry(entry)
    render(conn, "edit.html", student: student(), entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Register.get_entry!(student(), id)

    case Register.update_entry(entry, entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: student_entry_path(conn, :show, student(), entry))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student(), entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Register.get_entry!(student(), id)
    {:ok, _entry} = Register.delete_entry(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: student_entry_path(conn, :index, student()))
  end
end

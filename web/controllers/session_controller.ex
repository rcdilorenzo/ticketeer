defmodule Ticketeer.SessionController do
  use Ticketeer.Web, :controller

  alias Ticketeer.Admin

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    admin = Repo.get_by(Admin, username: username)
    if admin && Doorman.authenticate_user(admin, password) do
      conn
      |> put_session(:admin_id, admin.id)
      |> put_flash(:notice, "Logged in successfully")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "Invalid username or password")
      |> render("new.html")
    end
  end
end

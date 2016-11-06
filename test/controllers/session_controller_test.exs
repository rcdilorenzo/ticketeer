defmodule Ticketeer.SessionControllerTest do
  use Ticketeer.ConnCase

  alias Ticketeer.Admin

  setup %{conn: conn} do
    admin = Admin.changeset(%Admin{
      name: "Jim's Father",
      username: "jim.father"
    }, %{password: "supersecret"}) |> Repo.insert!

    {:ok, conn: conn, admin: admin}
  end

  test "GET /sessions/new", %{conn: conn} do
    conn = get conn, "/sessions/new"
    assert html_response(conn, 200) =~ "Login"
  end

  test "logging in successfully", %{conn: conn, admin: admin} do
    conn = post conn, "/sessions", %{session: %{username: admin.username, password: "supersecret"}}
    assert get_flash(conn, :notice) == "Logged in successfully"
    assert get_session(conn, :admin_id) == admin.id
    html_response(conn, 302)
  end

  test "logging in with incorrect password", %{conn: conn, admin: admin} do
    conn = post conn, "/sessions", %{session: %{username: admin.username, password: "baloney"}}
    assert get_flash(conn, :error) == "Invalid username or password"
    assert html_response(conn, 200) =~ "Invalid username or password"
  end
end

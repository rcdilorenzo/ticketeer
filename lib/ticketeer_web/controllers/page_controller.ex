defmodule TicketeerWeb.PageController do
  use TicketeerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

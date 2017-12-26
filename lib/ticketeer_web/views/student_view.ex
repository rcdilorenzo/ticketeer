defmodule TicketeerWeb.StudentView do
  use TicketeerWeb, :view

  def tcount(student) do
    Ticketeer.Register.ticket_count(student)
  end
end

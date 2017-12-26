defmodule TicketeerWeb.EntryView do
  use TicketeerWeb, :view

  @timezone "EST"

  def tx(date) do
    date
    |> Timex.to_datetime
    |> Timex.Timezone.convert(@timezone)
  end

  def inserted(entry) do
    tx(entry.inserted_at)
    |> Timex.format!("%m/%d/%Y", :strftime)
  end

  def inserted(entry, :relative) do
    tx(entry.inserted_at)
    |> Timex.format!("{relative}", :relative)
  end
end

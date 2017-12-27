defmodule Ticketeer.OnenoteImport do
  alias Ticketeer.Register.Entry
  alias Ticketeer.Repo

  def import_csv(filename, student_id) do
    CSVLixir.read(filename)
    |> Enum.to_list
    |> Enum.map(&import_csv_row(&1, student_id))
  end

  def import_csv_row(row = [r_date, r_description, r_amount, _balance], student_id) do
    with {:ok, date} <- Timex.parse(String.trim(r_date), "{M}/{D}/{YYYY}"),
         {amount, ""} <- Integer.parse(r_amount) do
      %Entry{}
      |> Entry.changeset(%{
            student_id: student_id, description: r_description, amount: amount})
      |> Ecto.Changeset.put_change(:inserted_at, Timex.shift(date, hours: 12))
      |> Repo.insert!
    else
      e ->
        {:error, :cannot_parse, e}
    end
  end
end

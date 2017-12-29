defmodule Ticketeer.Register do
  @moduledoc """
  The Register context.
  """

  import Ecto.Query, warn: false
  alias Ticketeer.Repo

  alias Ticketeer.Register.Entry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries(student) do
    list_entries(student, :query_only)
    |> Repo.all
  end

  def list_entries(student, :query_only) do
    query = from e in Entry,
      where: e.student_id == ^student.id,
      order_by: [desc: :inserted_at]
  end

  def list_entries(student, :paginated, opts \\ [page: 1]) do
    list_entries(student, :query_only)
    |> Repo.paginate(opts)
  end

  def ticket_count(student) do
    query = from e in Entry,
      where: e.student_id == ^student.id,
      group_by: e.student_id,
      select: %{ balance: sum(e.amount) }
    result = Repo.one(query) || %{balance: 0}
    result[:balance]
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(student, id) do
    Repo.get_by!(Entry, id: id, student_id: student.id)
  end

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{source: %Entry{}}

  """
  def change_entry(%Entry{} = entry) do
    Entry.changeset(entry, %{})
  end
end

defmodule Ticketeer.RegisterTest do
  use Ticketeer.DataCase

  alias Ticketeer.Register

  describe "entries" do
    alias Ticketeer.Register.Entry

    @valid_attrs %{amount: 42, description: "some description"}
    @update_attrs %{amount: 43, description: "some updated description"}
    @invalid_attrs %{amount: nil, description: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Register.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Register.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Register.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Register.create_entry(@valid_attrs)
      assert entry.amount == 42
      assert entry.description == "some description"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Register.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, entry} = Register.update_entry(entry, @update_attrs)
      assert %Entry{} = entry
      assert entry.amount == 43
      assert entry.description == "some updated description"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Register.update_entry(entry, @invalid_attrs)
      assert entry == Register.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Register.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Register.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Register.change_entry(entry)
    end
  end
end

defmodule Ticketeer.PeopleTest do
  use Ticketeer.DataCase

  alias Ticketeer.People

  describe "students" do
    alias Ticketeer.People.Student

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> People.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert People.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert People.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = People.create_student(@valid_attrs)
      assert student.name == "some name"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, student} = People.update_student(student, @update_attrs)
      assert %Student{} = student
      assert student.name == "some updated name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_student(student, @invalid_attrs)
      assert student == People.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = People.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> People.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = People.change_student(student)
    end
  end

  describe "users" do
    alias Ticketeer.People.User

    @valid_attrs %{email: "some email", username: "some username"}
    @update_attrs %{email: "some updated email", username: "some updated username"}
    @invalid_attrs %{email: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> People.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert People.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert People.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = People.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = People.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_user(user, @invalid_attrs)
      assert user == People.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = People.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> People.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = People.change_user(user)
    end
  end
end

defmodule TicketeerWeb.StudentControllerTest do
  use TicketeerWeb.ConnCase

  alias Ticketeer.People

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:student) do
    {:ok, student} = People.create_student(@create_attrs)
    student
  end

  describe "index" do
    test "lists all students", %{conn: conn} do
      conn = get conn, student_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Students"
    end
  end

  describe "new student" do
    test "renders form", %{conn: conn} do
      conn = get conn, student_path(conn, :new)
      assert html_response(conn, 200) =~ "New Student"
    end
  end

  describe "create student" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, student_path(conn, :create), student: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == student_path(conn, :show, id)

      conn = get conn, student_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Student"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, student_path(conn, :create), student: @invalid_attrs
      assert html_response(conn, 200) =~ "New Student"
    end
  end

  describe "edit student" do
    setup [:create_student]

    test "renders form for editing chosen student", %{conn: conn, student: student} do
      conn = get conn, student_path(conn, :edit, student)
      assert html_response(conn, 200) =~ "Edit Student"
    end
  end

  describe "update student" do
    setup [:create_student]

    test "redirects when data is valid", %{conn: conn, student: student} do
      conn = put conn, student_path(conn, :update, student), student: @update_attrs
      assert redirected_to(conn) == student_path(conn, :show, student)

      conn = get conn, student_path(conn, :show, student)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, student: student} do
      conn = put conn, student_path(conn, :update, student), student: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Student"
    end
  end

  describe "delete student" do
    setup [:create_student]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete conn, student_path(conn, :delete, student)
      assert redirected_to(conn) == student_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, student_path(conn, :show, student)
      end
    end
  end

  defp create_student(_) do
    student = fixture(:student)
    {:ok, student: student}
  end
end

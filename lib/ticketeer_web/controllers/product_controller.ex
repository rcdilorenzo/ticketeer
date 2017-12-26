defmodule TicketeerWeb.ProductController do
  use TicketeerWeb, :controller

  alias Ticketeer.Store
  alias Ticketeer.Store.Product
  alias Ticketeer.People.Student

  plug :load_resource,
    model: Student,
    id_name: "student_id",
    persisted: true,
    only: [:purchase_index, :purchase]

  plug :load_resource,
    model: Product,
    persisted: true,
    only: [:purchase]

  def purchase_index(conn, _params) do
    student = conn.assigns.student
    products = Store.list_products()
    render(conn, "purchase_index.html", student: student, products: products)
  end

  def purchase(conn, _params) do
    student = conn.assigns.student
    product = conn.assigns.product
    case Store.purchase(student, product) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Product purchased successfully.")
        |> redirect(to: student_entry_path(conn, :index, student))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Product cannot be purchased.")
        |> redirect(to: student_product_path(conn, :index, student))
    end
  end

  def index(conn, _params) do
    products = Store.list_products()
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Store.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Store.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    product = Store.get_product!(id)
    changeset = Store.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Store.get_product!(id)

    case Store.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Store.get_product!(id)
    {:ok, _product} = Store.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: product_path(conn, :index))
  end
end

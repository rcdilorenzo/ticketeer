defmodule TicketeerWeb.Router do
  use TicketeerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TicketeerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", StudentController, :dashboard

    resources "/users", UserController

    resources "/students", StudentController do
      resources "/tickets", EntryController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TicketeerWeb do
  #   pipe_through :api
  # end
end

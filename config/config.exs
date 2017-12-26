# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ticketeer,
  ecto_repos: [Ticketeer.Repo]

# Configures the endpoint
config :ticketeer, TicketeerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uhm/1VlFjDQU6o2zowzjUjQDQMYBJ+fUPS3mTgTAyoZVifsxgBgVHdL1d6LP1oSg",
  render_errors: [view: TicketeerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ticketeer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix_slime, :use_slim_extension, true

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine

config :canary, repo: Ticketeer.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

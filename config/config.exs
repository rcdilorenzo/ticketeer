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
config :ticketeer, Ticketeer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "F0res5Tooy7N+TFp6E5p2aWXQ2P1jx5OnGQSFbAgCwU4R79uGFTWknBIEpBA/Gjl",
  render_errors: [view: Ticketeer.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ticketeer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure authentication package
config :doorman,
  repo: Ticketeer.Repo,
  secure_with: Doorman.Auth.Bcrypt,
  user_module: Ticketeer.Admin

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :catcasts_phx,
  ecto_repos: [CatcastsPhx.Repo]

# Configures the endpoint
config :catcasts_phx, CatcastsPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "idBTCSV4gmGFm3FzOKHArC9YBBWjTja0bFmYKXN42nEbpHKTJsgf16VeIe8qzrdm",
  render_errors: [view: CatcastsPhxWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CatcastsPhx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# ueberauth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :paf,
  ecto_repos: [Paf.Repo]

# Configures the endpoint
config :paf, PafWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "w6Lqrz66F8tiQ8C6ss0vNV4brNoPYXiMlsd4mJDP5zfzMPy23hJD/E7SRl6oirIe",
  render_errors: [view: PafWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Paf.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

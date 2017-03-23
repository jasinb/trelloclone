# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :trelloclone,
  ecto_repos: [Trelloclone.Repo]

# Configures the endpoint
config :trelloclone, Trelloclone.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "afk758bAW4t6u/W6ikg+Hpj1Im+plWuOsnUuMDDiJKOZ62vH+HGL9pC7sN3e7H6H",
  render_errors: [view: Trelloclone.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Trelloclone.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Trelloclone",
  ttl: { 7, :days },
  verify_issuer: true,
  secret_key: %{"k" => "yIX-W86_ntiDojKJ4JO__g", "kty" => "oct"},
  serializer: Trelloclone.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

import Config

# Configure event store
config :conduit, Conduit.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  database: "conduit_eventstore_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :conduit, Conduit.Repo,
  database: "conduit_readstore_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :conduit, ConduitWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ZBb6LZqbq+Zf+OBiSwM0P9TM1vdA2ncbBdBil6KAKSnsRgvfUnXxcutlEDThvIOY",
  server: false

# In test we don't send emails.
config :conduit, Conduit.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

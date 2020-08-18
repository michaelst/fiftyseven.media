use Mix.Config

config :fiftysevenmedia, FSMWeb.Endpoint,
url: [host: "fiftyseven.media", port: 443],
http: [port: 4000],
secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
debug_errors: false,
server: true

config :fiftysevenmedia, FSM.Repo,
  username: "postgres",
  database: "fifty_seven_media",
  hostname: "10.122.112.3",
  password: System.fetch_env!("DB_PASSWORD"),
  pool_size: 5

config :logger, level: :info

config :fiftysevenmedia, FSM.Guardian, secret_key: System.fetch_env!("GUARDIAN_SECRET")

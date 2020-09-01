use Mix.Config

config :fiftysevenmedia, FSMWeb.Endpoint,
url: [host: "fiftyseven.media", port: 443],
http: [port: 4000],
debug_errors: false,
server: true

config :fiftysevenmedia, FSM.Repo,
  database: "fifty_seven_media",
  pool_size: 5

config :logger, level: :info

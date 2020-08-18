use Mix.Config

config :fiftysevenmedia, FSMWeb.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :fiftysevenmedia, FSM.Repo, database: "fifty_seven_media_test"

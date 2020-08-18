use Mix.Config

config :fiftysevenemdia,
  env: Mix.env(),
  ecto_repos: [FSM.Repo]

config :fiftysevenemdia, FSMWeb.Endpoint, render_errors: [view: FSMWeb.ErrorView, accepts: ~w(html json)]

config :fiftysevenemdia, FSM.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :fiftysevenemdia, FSM.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Fifty Seven Media",
  ttl: {365, :days},
  verify_issuer: true

config :sentry,
  dsn: System.get_env("SENTRY_DSN"),
  environment_name: Mix.env(),
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  tags: %{
    env: "production"
  },
  included_environments: [:prod]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"

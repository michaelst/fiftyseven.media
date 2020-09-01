import Config

config :fiftysevenmedia, FSMWeb.Endpoint, secret_key_base: File.read!("/etc/secrets/SECRET_KEY_BASE")

config :fiftysevenmedia, FSM.Repo,
  hostname: System.fetch_env!("DB_HOSTNAME"),
  username: System.fetch_env!("DB_USERNAME"),
  password: File.read!("/etc/secrets/DB_PASSWORD")

config :fiftysevenmedia, FSM.Guardian, secret_key: File.read!("/etc/secrets/GUARDIAN_SECRET")

config :sentry,
  dsn: File.read!("/etc/secrets/SENTRY_DSN")

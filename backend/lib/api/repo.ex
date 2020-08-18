defmodule FSM.Repo do
  use Ecto.Repo,
    otp_app: :fiftysevenmedia,
    adapter: Ecto.Adapters.Postgres
end

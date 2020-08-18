ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(FSM.Repo, :manual)
Absinthe.Test.prime(FSMWeb.Schema)
{:ok, _} = Application.ensure_all_started(:ex_machina)

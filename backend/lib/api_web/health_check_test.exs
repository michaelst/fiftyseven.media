defmodule HealthCheckTest do
  use Spendable.Web.ConnCase, async: true

  test "health check", %{conn: conn} do
    conn
    |> get("/_health")
    |> response(200)
  end
end

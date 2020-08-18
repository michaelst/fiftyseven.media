defmodule FSMWeb.AdminContext do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case Guardian.Plug.current_resource(conn) do
      nil -> send_resp(conn, 404, "Not Found")
      user -> check_for_admin_user(conn, user)
    end
  end

  def check_for_admin_user(conn, %{id: 1}), do: conn
  def check_for_admin_user(conn, _user), do: send_resp(conn, 404, "Not Found")
end

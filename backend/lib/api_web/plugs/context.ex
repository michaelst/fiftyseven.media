defmodule FSMWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn

      user ->
        conn
        |> put_private(:absinthe, %{context: %{current_user: user}})
        |> check_for_admin_user(user)
    end
  end

  def check_for_admin_user(conn, %{id: 1} = user) do
    put_private(conn, :absinthe, %{context: %{admin_user: user}})
  end

  def check_for_admin_user(conn, _user), do: conn
end

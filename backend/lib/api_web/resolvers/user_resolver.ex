defmodule FSMWeb.UserResolver do
  alias FSM.Users.User
  alias FSM.Repo

  def login(params, _info) do
    with {:ok, user} <- FSM.Users.Session.authenticate(params, Repo),
         {:ok, jwt, _} <- FSM.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt, user: user}}
    end
  end

  def create(%{user: params}, %{context: %{admin_user: %{id: _}}}) do
    struct(User)
    |> User.changeset(params)
    |> Repo.insert()
  end

  def create(_args, _context), do: {:error, "Forbidden"}

  def update(%{id: id, user: params}, %{context: %{admin_user: %{id: _}}}) do
    Repo.get!(User, id)
    |> User.changeset(params)
    |> Repo.update()
  end

  def update(%{user: params}, %{context: %{current_user: %{id: id}}}) do
    Repo.get!(User, id)
    |> User.changeset(params)
    |> Repo.update()
  end

  def update(_args, _context), do: {:error, "Forbidden"}
end

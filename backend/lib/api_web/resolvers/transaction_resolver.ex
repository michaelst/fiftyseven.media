defmodule FSMWeb.TransactionResolver do
  import Ecto.Query
  alias FSM.Users.Transaction

  def all(_args, %{context: %{admin_user: %{id: _}}}) do
    transactions =
      Transaction
      |> order_by([transaction], {:desc, transaction.date})
      |> FSM.Repo.all()
      |> FSM.Repo.preload(:user)
      |> Enum.map(&Map.put(&1, :user, &1.user.username))

    {:ok, transactions}
  end

  def all(_args, %{context: %{current_user: user}}) do
    transactions =
      Transaction
      |> where([transaction], transaction.user_id == ^user.id)
      |> order_by([transaction], {:desc, transaction.date})
      |> FSM.Repo.all()
      |> Enum.map(&Map.put(&1, :user, user.username))

    {:ok, transactions}
  end
end

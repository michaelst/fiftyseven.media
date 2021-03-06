defmodule FSM.Users.Session do
  alias FSM.Users.User

  def authenticate(params, repo) do
    user = repo.get_by(User, email: String.downcase(params.email))

    case check_password(user, params.password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Bcrypt.verify_pass(password, user.password_hash)
    end
  end
end

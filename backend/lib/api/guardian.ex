defmodule FSM.Guardian do
  use Guardian, otp_app: :fiftysevenmedia

  alias FSM.Repo
  alias FSM.Users.User

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    {:ok, Repo.get(User, id)}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end

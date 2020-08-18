defmodule FSM.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FSM.Users.User

  schema "users" do
    field :balance, :decimal
    field :chart_account_id, :integer
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :username, :string

    many_to_many :artists, FSM.Artists.Artist, join_through: "artists_users"
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :balance])
    |> validate_required([:username])
    |> hash_password
  end

  defp hash_password(%{changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end

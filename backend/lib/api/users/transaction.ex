defmodule FSM.Users.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias FSM.Users.Transaction
  alias FSM.Users.User

  schema "transactions" do
    field :amount, :decimal
    field :date, :date
    field :note, :string
    field :auto, :boolean, default: false

    belongs_to :user, User
  end

  def changeset(%Transaction{} = transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :date, :note, :auto, :user_id])
    |> validate_required([:amount, :date])
  end
end

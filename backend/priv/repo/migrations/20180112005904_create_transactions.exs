defmodule FSM.Repo.Migrations.CreateTransactionHistory do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :date, :date
      add :user_id, references(:users), null: false
      add :amount, :decimal, precision: 10, scale: 4, null: false
      add :note, :text
      add :auto, :boolean, default: false, null: false
    end
  end
end

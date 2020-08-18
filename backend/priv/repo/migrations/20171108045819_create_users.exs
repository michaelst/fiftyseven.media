defmodule FSM.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username,      :text
      add :password_hash, :text
      add :email,         :text
      add :balance,       :decimal, precision: 10, scale: 4, null: false
    end
  end
end

defmodule FSM.Repo.Migrations.AddChartAccountIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :chart_account_id, :integer
    end
  end
end

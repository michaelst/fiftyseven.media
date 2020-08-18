defmodule FSM.Repo.Migrations.CreateSongPercentages do
  use Ecto.Migration

  def change do
    create table(:song_percentages) do
      add :song_id, references(:songs), null: false
      add :user_id, references(:users), null: false
      add :percentage, :decimal, precision: 6, scale: 4, null: false
    end
  end
end

defmodule FSM.Repo.Migrations.CreateAlbumPercentages do
  use Ecto.Migration

  def change do
    create table(:album_percentages) do
      add :album_id, references(:albums), null: false
      add :user_id, references(:users), null: false
      add :percentage, :decimal, precision: 6, scale: 4, null: false
    end
  end
end

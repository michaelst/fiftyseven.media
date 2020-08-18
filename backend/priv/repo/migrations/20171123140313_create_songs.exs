defmodule FSM.Repo.Migrations.AddSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :artist_id, references(:artists), null: false
      add :title,     :text
      add :isrc_code, :text
    end
  end
end

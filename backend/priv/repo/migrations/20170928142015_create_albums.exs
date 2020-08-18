defmodule FSM.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :artist_id,      references(:artists), null: false
      add :awal_bundle_id, :text
      add :title,          :text
      add :artwork_url,    :text
      add :listen_url,     :text
      add :publish,        :boolean, null: false, default: false
    end
  end
end

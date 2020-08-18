defmodule FSM.Repo.Migrations.AddRoyalties do
  use Ecto.Migration

  def change do
    create table(:royalties) do
      add :artist_id,                  references(:artists), null: true
      add :album_id,                   references(:albums), null: true
      add :song_id,                    references(:songs), null: true
      add :incoming_batch_source_name, :text
      add :incoming_batch_description, :text
      add :use_type,                   :text
      add :commercial_model_type,      :text
      add :territory_of_sale,          :text
      add :quantity,                   :integer
      add :amount,                     :decimal, precision: 10, scale: 4
      add :mechanicals_included,       :boolean, null: false, default: false
      add :inserted_on,                :date
    end
  end
end

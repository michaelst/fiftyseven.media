defmodule FSM.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name,             :text
      add :keywords,         :text
      add :slug,             :text
      add :list_image_url,   :text
      add :background_style, :text
      add :header_image,     :text
      add :bio,              :text
      add :videos,           :text
      add :facebook_url,     :text
      add :twitter_url,      :text
      add :youtube_url,      :text
      add :spotify_url,      :text
      add :publish,          :boolean, null: false, default: false
    end
  end
end

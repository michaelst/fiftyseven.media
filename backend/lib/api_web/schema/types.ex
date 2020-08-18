defmodule FSMWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :artist do
    field :id, :id
    field :name, :string
    field :keywords, :string
    field :slug, :string
    field :list_image_url, :string
    field :background_style, :string
    field :header_image, :string
    field :bio, :string
    field :videos, :string
    field :facebook_url, :string
    field :twitter_url, :string
    field :youtube_url, :string
    field :spotify_url, :string
    field :publish, :boolean
    field :albums, list_of(:album)
  end

  object :album do
    field :artist_id, :id
    field :artist, :artist
    field :artwork_url, :string
    field :id, :id
    field :listen_url, :string
    field :publish, :boolean
    field :title, :string
  end

  object :song do
    field :artist_id, :id
    field :artist, :artist
    field :id, :id
    field :isrc_code, :string
    field :title, :string
  end

  object :royalty do
    field :album_id, :id
    field :album, :album
    field :amount, :string
    field :artist_id, :id
    field :artist, :artist
    field :commercial_model_type, :string
    field :earned_amount, :string
    field :id, :id
    field :incoming_batch_description, :string
    field :incoming_batch_source_name, :string
    field :inserted_on, :string
    field :mechanicals_included, :boolean
    field :percentage, :string
    field :quantity, :integer
    field :song_id, :id
    field :song, :song
    field :territory_of_sale, :string
    field :use_type, :string
  end

  object :transaction do
    field :id, :id
    field :amount, :string
    field :date, :string
    field :note, :string
    field :user, :string
  end

  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :balance, :string
  end

  object :session do
    field :token, :string
    field :user, :user
  end
end

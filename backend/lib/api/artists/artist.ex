defmodule FSM.Artists.Artist do
  use Ecto.Schema
  import Ecto.Changeset
  alias FSM.Artists.Artist
  alias FSM.Releases.Album
  alias FSM.Users.User

  schema "artists" do
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

    has_many :albums, Album
    many_to_many :users, User, join_through: "artists_users"
  end

  def changeset(%Artist{} = artist, attrs) do
    artist
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

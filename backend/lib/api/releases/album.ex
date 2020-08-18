defmodule FSM.Releases.Album do
  use Ecto.Schema
  import Ecto.Changeset
  alias FSM.Artists.Artist
  alias FSM.Releases.Album
  alias FSM.Releases.AlbumPercentages

  schema "albums" do
    field :artwork_url, :string
    field :awal_bundle_id, :string
    field :listen_url, :string
    field :publish, :boolean
    field :title, :string

    belongs_to :artist, Artist
    has_many :percentages, AlbumPercentages
  end

  def changeset(%Album{} = album, attrs) do
    album
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

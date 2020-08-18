defmodule FSM.Releases.Song do
  use Ecto.Schema
  import Ecto.Changeset
  alias FSM.Artists.Artist
  alias FSM.Releases.Song
  alias FSM.Releases.SongPercentages

  schema "songs" do
    field :title, :string
    field :isrc_code, :string

    belongs_to :artist, Artist
    has_many :percentages, SongPercentages
  end

  def changeset(%Song{} = song, attrs) do
    song
    |> cast(attrs, [:title, :isrc_code])
    |> validate_required([:title, :isrc_code])
  end
end

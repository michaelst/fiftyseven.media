defmodule FSM.Releases.Royalty do
  use Ecto.Schema
  import Ecto.Changeset
  alias FSM.Artists.Artist
  alias FSM.Releases.Album
  alias FSM.Releases.Song
  alias FSM.Releases.Royalty

  schema "royalties" do
    field :incoming_batch_source_name, :string
    field :incoming_batch_description, :string
    field :use_type, :string
    field :commercial_model_type, :string
    field :territory_of_sale, :string
    field :quantity, :integer
    field :amount, :decimal
    field :mechanicals_included, :boolean
    field :inserted_on, :date

    belongs_to :artist, Artist
    belongs_to :album, Album
    belongs_to :song, Song
  end

  def changeset(%Royalty{} = royalty, attrs) do
    royalty
    |> cast(attrs, [
      :album_id,
      :amount,
      :artist_id,
      :commercial_model_type,
      :incoming_batch_description,
      :incoming_batch_source_name,
      :inserted_on,
      :mechanicals_included,
      :quantity,
      :song_id,
      :territory_of_sale,
      :use_type
    ])
    |> validate_required([:mechanicals_included, :inserted_on])
  end
end

defmodule FSM.Releases.AlbumPercentages do
  use Ecto.Schema
  alias FSM.Users.User
  alias FSM.Releases.Album

  schema "album_percentages" do
    field :percentage, :decimal

    belongs_to :user, User
    belongs_to :album, Album
  end
end

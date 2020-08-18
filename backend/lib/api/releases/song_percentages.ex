defmodule FSM.Releases.SongPercentages do
  use Ecto.Schema
  alias FSM.Users.User
  alias FSM.Releases.Song

  schema "song_percentages" do
    field :percentage, :decimal

    belongs_to :user, User
    belongs_to :song, Song
  end
end

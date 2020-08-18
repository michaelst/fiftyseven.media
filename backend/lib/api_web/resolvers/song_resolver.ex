defmodule FSMWeb.SongResolver do
  alias FSM.Releases.Song

  def find(%{id: id}, _info) do
    case FSM.Repo.get(Song, id) do
      nil -> {:error, "Song id #{id} not found"}
      song -> {:ok, FSM.Repo.preload(song, :percentages)}
    end
  end

  def create(args, _info) do
    %Song{}
    |> Song.changeset(args)
    |> FSM.Repo.insert()
  end
end

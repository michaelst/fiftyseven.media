defmodule FSMWeb.ArtistResolver do
  import Ecto.Query
  alias FSM.Artists.Artist
  alias FSM.Releases.Album

  def all(_args, _info) do
    {:ok,
     FSM.Repo.all(Artist) |> FSM.Repo.preload(albums: from(album in Album, order_by: {:desc, album.awal_bundle_id}))}
  end

  def find(%{id: id}, _info) do
    case FSM.Repo.get(Artist, id)
         |> FSM.Repo.preload(albums: from(album in Album, order_by: {:desc, album.awal_bundle_id})) do
      nil -> {:error, "Artist id #{id} not found"}
      artist -> {:ok, artist}
    end
  end

  def create(args, _info) do
    %Artist{}
    |> Artist.changeset(args)
    |> FSM.Repo.insert()
  end
end

defmodule FSMWeb.AlbumResolver do
  import Ecto.Query
  alias FSM.Releases.Album

  def all(args, _info) do
    page_size = args[:first]
    offset = if page_size, do: (args[:offset] || 0) * page_size

    query = order_by(Album, [album], {:desc, album.awal_bundle_id})

    query =
      if page_size,
        do: query |> limit(^page_size) |> offset(^offset),
        else: query

    albums =
      query
      |> FSM.Repo.all()
      |> FSM.Repo.preload(:artist)

    {:ok, albums}
  end

  def find(%{id: id}, _info) do
    case FSM.Repo.get(Album, id) do
      nil -> {:error, "Album id #{id} not found"}
      album -> {:ok, album}
    end
  end

  def create(args, _info) do
    %Album{}
    |> Album.changeset(args)
    |> FSM.Repo.insert()
  end
end

defmodule FSMWeb.RoyaltyResolver do
  import Ecto.Query
  alias FSM.Releases.Royalty
  alias FSM.Releases.AlbumPercentages
  alias FSM.Releases.SongPercentages

  def all(args, info) do
    page_size = args[:first] || 100
    offset = (args[:offset] || 0) * page_size

    royalties =
      Royalty
      |> limit(^page_size)
      |> offset(^offset)
      |> join(:left, [royalty], artist in assoc(royalty, :artist))
      |> filter_results(info)
      |> order_by([royalty], {:desc, royalty.inserted_on})
      |> order_by([_royalty, artist], {:asc, artist.name})
      |> order_by([royalty], {:desc, royalty.amount})
      |> FSM.Repo.all()
      |> perform_preload(info)
      |> Enum.map(&calculate_percentage(&1, info))

    {:ok, royalties}
  end

  defp calculate_percentage(%{song_id: nil} = royalty, %{context: %{admin_user: %{id: _}}}) do
    percentage =
      royalty.album.percentages
      |> Enum.reduce(Decimal.new(100), fn x, acc ->
        Decimal.sub(acc, x.percentage)
      end)

    earned_amount =
      royalty.amount
      |> Decimal.mult(percentage)
      |> Decimal.div(Decimal.new(100))

    royalty
    |> Map.put(:percentage, Decimal.round(percentage, 2))
    |> Map.put(:earned_amount, Decimal.round(earned_amount, 4))
  end

  defp calculate_percentage(royalty, %{context: %{admin_user: %{id: _}}}) do
    percentage =
      royalty.song.percentages
      |> Enum.reduce(Decimal.new(100), fn x, acc ->
        Decimal.sub(acc, x.percentage)
      end)

    earned_amount =
      royalty.amount
      |> Decimal.mult(percentage)
      |> Decimal.div(Decimal.new(100))

    royalty
    |> Map.put(:percentage, Decimal.round(percentage, 2))
    |> Map.put(:earned_amount, Decimal.round(earned_amount, 4))
  end

  defp calculate_percentage(%{song_id: nil} = royalty, _info) do
    percentage =
      royalty.album.percentages
      |> List.first()
      |> Map.get(:percentage)

    earned_amount =
      royalty.amount
      |> Decimal.mult(percentage)
      |> Decimal.div(Decimal.new(100))

    royalty
    |> Map.put(:percentage, Decimal.round(percentage, 2))
    |> Map.put(:earned_amount, Decimal.round(earned_amount, 4))
  end

  defp calculate_percentage(royalty, _info) do
    percentage =
      royalty.song.percentages
      |> List.first()
      |> Map.get(:percentage)

    earned_amount =
      royalty.amount
      |> Decimal.mult(percentage)
      |> Decimal.div(Decimal.new(100))

    royalty
    |> Map.put(:percentage, Decimal.round(percentage, 2))
    |> Map.put(:earned_amount, Decimal.round(earned_amount, 4))
  end

  defp perform_preload(query, %{context: %{admin_user: %{id: _}}}) do
    FSM.Repo.preload(query, [
      :artist,
      [album: :percentages],
      [song: :percentages]
    ])
  end

  defp perform_preload(query, %{context: %{current_user: %{id: id}}}) do
    FSM.Repo.preload(query, [
      :artist,
      [album: [percentages: from(ap in AlbumPercentages, where: ap.user_id == ^id)]],
      [song: [percentages: from(sp in SongPercentages, where: sp.user_id == ^id)]]
    ])
  end

  defp filter_results(query, %{context: %{admin_user: %{id: _}}}), do: query

  defp filter_results(query, %{context: %{current_user: %{id: id}}}) do
    album_ids =
      from(ap in AlbumPercentages, select: ap.album_id)
      |> where([ap], ap.user_id == ^id)
      |> FSM.Repo.all()

    song_ids =
      from(sp in SongPercentages, select: sp.song_id)
      |> where([sp], sp.user_id == ^id)
      |> FSM.Repo.all()

    where(
      query,
      [royalty],
      (royalty.album_id in ^album_ids and is_nil(royalty.song_id)) or royalty.song_id in ^song_ids
    )
  end
end

defmodule FSMWeb.RoyaltyController do
  use FSMWeb, :controller
  import Ecto.Query
  import Utils.Decimal
  import Utils.Decimal
  alias FSM.Releases.Royalty
  alias FSM.Releases.Song
  alias FSM.Releases.Album
  alias FSM.Artists.Artist
  alias FSM.Users.Transaction
  alias FSM.Users.User

  def upload(conn, params) do
    songs = FSM.Repo.all(Song)
    albums = FSM.Repo.all(Album)
    artists = FSM.Repo.all(Artist)

    params["statement"]
    |> Map.get(:path)
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.map(fn line ->
      Royalty.changeset(struct(Royalty), %{
        album_id: albums |> Enum.find(%{}, &(&1.awal_bundle_id == line["BUNDLE_ID"])) |> Map.get(:id, nil),
        amount: line["DISTRIBUTED_AMOUNT"],
        artist_id: artists |> Enum.find(%{}, &(&1.name == line["BUNDLE_ARTIST"])) |> Map.get(:id, nil),
        commercial_model_type: line["COMMERCIAL_MODEL_TYPE"],
        incoming_batch_description: line["INCOMING_BATCH_DESCRIPTION"],
        incoming_batch_source_name: line["INCOMING_BATCH_SOURCE_NAME"],
        inserted_on: Date.utc_today(),
        mechanicals_included: line["INCLUDES_MECHANICALS"] == "Y",
        quantity: line["QUANTITY_SUM"],
        song_id: songs |> Enum.find(%{}, &(&1.isrc_code == line["TRACK_ISRC"])) |> Map.get(:id, nil),
        territory_of_sale: line["TERRITORY_OF_SALE"],
        use_type: line["USE_TYPE"]
      })
    end)
    |> Enum.with_index()
    |> Enum.reduce(Ecto.Multi.new(), fn {changeset, index}, multi ->
      Ecto.Multi.insert(multi, Integer.to_string(index), changeset)
    end)
    |> FSM.Repo.transaction()
    |> case do
      {:ok, _result} ->
        send_resp(conn, 200, "Success")

      {:error, _, changeset, _} ->
        render(conn, FSMWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def add_royalties(conn, _params) do
    Royalty
    |> where([royalty], royalty.inserted_on >= ^%{Date.utc_today() | day: 1})
    |> FSM.Repo.all()
    |> FSM.Repo.preload([
      [album: :percentages],
      [song: :percentages]
    ])
    |> Enum.map(fn royalty ->
      if is_nil(royalty.song_id),
        do: Enum.map(royalty.album.percentages, &Map.put(&1, :amount, royalty.amount)),
        else: Enum.map(royalty.song.percentages, &Map.put(&1, :amount, royalty.amount))
    end)
    |> List.flatten()
    |> Enum.group_by(& &1.user_id)
    |> Enum.map(fn {user_id, percentages} ->
      amount =
        Enum.reduce(percentages, ~d(0), fn p, acc ->
          (p.amount ^^^ p.percentage | 100) &&& acc
        end)

      Transaction.changeset(struct(Transaction), %{
        amount: amount,
        auto: true,
        date: Date.utc_today(),
        note: "Royalties",
        user_id: user_id
      })
    end)
    |> Enum.with_index()
    |> Enum.reduce(Ecto.Multi.new(), fn {changeset, index}, multi ->
      Ecto.Multi.insert(multi, Integer.to_string(index), changeset)
    end)
    |> FSM.Repo.transaction()
    |> case do
      {:ok, result} ->
        result =
          Enum.map(result, fn {_k, v} -> v end)
          |> FSM.Repo.preload(user: from(u in User, select: [:chart_account_id]))

        total =
          Royalty
          |> where([royalty], royalty.inserted_on >= ^%{Date.utc_today() | day: 1})
          |> FSM.Repo.aggregate(:sum, :amount)
          |> Decimal.round(4)

        owed_total =
          result
          |> Enum.reduce(~d(0), fn t, acc -> acc &&& Decimal.round(t.amount, 4) end)

        lines =
          result
          |> Enum.map(&%{amount: Decimal.round(&1.amount, 4), chart_account_id: &1.user.chart_account_id})
          # music royalties chart account id
          |> Enum.concat([%{amount: total ||| owed_total, chart_account_id: 6_440_130}])

        total
        |> Decimal.round(4)
        |> ZipBooks.create_journal_entry(lines)

        send_resp(conn, 200, "Success")

      {:error, _, changeset, _} ->
        render(conn, FSMWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update_balances(conn, _params) do
    from(user in User, where: user.id != 1)
    |> FSM.Repo.all()
    |> Enum.map(fn user ->
      user
      |> User.changeset(%{
        balance: FSM.Repo.aggregate(from(t in Transaction, where: t.user_id == ^user.id), :sum, :amount)
      })
    end)
    |> Enum.with_index()
    |> Enum.reduce(Ecto.Multi.new(), fn {changeset, index}, multi ->
      Ecto.Multi.update(multi, Integer.to_string(index), changeset)
    end)
    |> FSM.Repo.transaction()
    |> case do
      {:ok, _result} ->
        send_resp(conn, 200, "Success")

      {:error, _, changeset, _} ->
        render(conn, FSMWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end

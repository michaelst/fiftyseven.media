defmodule FSMWeb.Schema do
  use Absinthe.Schema
  import_types(FSMWeb.Schema.Types)

  query do
    field :artists, list_of(:artist) do
      resolve(&FSMWeb.ArtistResolver.all/2)
    end

    field :artist, :artist do
      arg(:id, non_null(:id))
      resolve(&FSMWeb.ArtistResolver.find/2)
    end

    field :royalties, list_of(:royalty) do
      arg(:offset, :integer)
      arg(:first, :integer)
      resolve(&FSMWeb.RoyaltyResolver.all/2)
    end

    field :transactions, list_of(:transaction) do
      resolve(&FSMWeb.TransactionResolver.all/2)
    end

    field :albums, list_of(:album) do
      arg(:offset, :integer)
      arg(:first, :integer)
      resolve(&FSMWeb.AlbumResolver.all/2)
    end

    field :album, :album do
      arg(:id, non_null(:id))
      resolve(&FSMWeb.AlbumResolver.find/2)
    end

    field :song, :song do
      arg(:id, non_null(:id))
      resolve(&FSMWeb.SongResolver.find/2)
    end
  end

  input_object :user_params do
    field :username, :string
    field :email, :string
    field :password, :string
  end

  mutation do
    field :login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&FSMWeb.UserResolver.login/2)
    end

    field :create_user, :user do
      arg(:user, :user_params)
      resolve(&FSMWeb.UserResolver.create/2)
    end

    field :update_user, :user do
      arg(:id, :string)
      arg(:user, :user_params)
      resolve(&FSMWeb.UserResolver.update/2)
    end

    field :artist, :artist do
      arg(:name, non_null(:string))
      resolve(&FSMWeb.ArtistResolver.create/2)
    end
  end
end

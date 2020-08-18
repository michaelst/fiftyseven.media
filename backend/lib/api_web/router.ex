defmodule FSMWeb.Router do
  use FSMWeb, :router

  pipeline :graphql do
    plug Guardian.Plug.Pipeline, module: FSM.Guardian, error_handler: FSMWeb.AuthErrorHandler
    plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
    plug(Guardian.Plug.LoadResource, allow_blank: true)
    plug FSMWeb.Context
  end

  pipeline :admin do
    plug Guardian.Plug.Pipeline, module: FSM.Guardian, error_handler: FSMWeb.AuthErrorHandler
    plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(Guardian.Plug.LoadResource)
    plug FSMWeb.AdminContext
  end

  forward "/_health", HealthCheck

  scope "/" do
    pipe_through :admin

    post "/royalties/upload", FSMWeb.RoyaltyController, :upload
    post "/royalties/add-royalties", FSMWeb.RoyaltyController, :add_royalties
    post "/royalties/update-balances", FSMWeb.RoyaltyController, :update_balances
  end

  scope "/" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: FSMWeb.Schema
  end
end

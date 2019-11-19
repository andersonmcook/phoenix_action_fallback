defmodule PafWeb.Router do
  use PafWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PafWeb do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show]
  end
end

defmodule PafWeb.UserController do
  use PafWeb, :controller
  alias Paf.Accounts

  action_fallback PafWeb.JSONFallback

  @query_options ~w(
    name_like
    older_than
    younger_than
  )

  def index(_conn, params) do
    params
    |> Map.take(@query_options)
    |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
    |> Accounts.list_users()
  end

  def show(_conn, %{"id" => id}) do
    Accounts.get_user(id)
  end
end

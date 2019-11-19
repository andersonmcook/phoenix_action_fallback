defmodule PafWeb.UserController do
  use PafWeb, :controller

  alias Paf.Accounts

  @query_options ~w(
    name_like
    older_than
    younger_than
  )

  @take_keys ~w(
    age
    name
  )a

  def index(conn, params) do
    params
    |> Map.take(@query_options)
    |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
    |> Accounts.list_users()
    |> Response.json(conn, only: @take_keys)
  end

  def show(conn, %{"id" => id}) do
    id
    |> Accounts.get_user()
    |> Response.json(conn)
  end
end

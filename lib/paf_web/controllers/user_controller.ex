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
    id
    name
  )a

  @drop_keys ~w(
    __meta__
    __struct__
  )a

  def index(conn, params) do
    params
    |> Map.take(@query_options)
    |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
    |> Accounts.list_users()
    |> Enum.map(&Map.take(&1, @take_keys))
    |> (&json(conn, &1)).()
  end

  def show(conn, %{"id" => id}) do
    id
    |> Accounts.get_user()
    |> case do
      nil -> send_resp(conn, 404, "Not found")
      user -> json(conn, Map.drop(user, @drop_keys))
    end
  end
end

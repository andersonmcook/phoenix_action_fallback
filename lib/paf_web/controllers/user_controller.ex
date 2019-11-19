defmodule PafWeb.UserController do
  use PafWeb, :controller

  alias Paf.Accounts

  @query_options ~w(
    name_like
    older_than
    younger_than
  )

  def index(conn, params) do
    params
    |> Map.take(@query_options)
    |> Accounts.list_users()
    |> (&json(conn, &1)).()
  end

  def show(conn, %{"id" => id}) do
    id
    |> Accounts.get_user()
    |> case do
      nil -> send_resp(conn, 404, "Not found")
      user -> json(conn, user)
    end
  end
end

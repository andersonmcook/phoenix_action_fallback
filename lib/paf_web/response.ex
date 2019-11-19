defmodule Response do
  @moduledoc """
  Convenience for controllers
  """

  import Plug.Conn, only: [send_resp: 3]
  alias Phoenix.Controller

  @doc """
  Responds to client with JSON or error messages
  """
  @spec json(
          nil
          | map()
          | [map()]
          | {:ok, nil | map() | [map()]}
          | {:error, any()},
          Plug.Conn.t(),
          [except: [any()]] | [only: [any()]] | []
        ) :: Plug.Conn.t() | no_return()
  def json(input, conn, opts \\ [])

  def json(nil, conn, _opts) do
    send_resp(conn, 400, "Not found")
  end

  def json(list, conn, opts) when is_list(list) do
    Controller.json(conn, Enum.map(list, operation(opts)))
  end

  def json(map, conn, opts) when is_map(map) do
    Controller.json(conn, operation(opts).(map))
  end

  def json({:ok, coll}, conn, opts) do
    json(coll, conn, opts)
  end

  def json({:error, _}, conn, _opts) do
    send_resp(conn, 500, "Internal Server Error")
  end

  defp operation([]) do
    &Map.drop(&1, [:__meta__, :__struct__])
  end

  defp operation(except: except) when is_list(except) do
    &Map.drop(&1, [:__meta__ | [:__struct__ | except]])
  end

  defp operation(only: only) when is_list(only) do
    &Map.take(&1, only)
  end
end

defmodule PafWeb.JSONFallback do
  import Phoenix.Controller, only: [json: 2]
  import Plug.Conn, only: [send_resp: 3]

  @type data :: nil | map() | [map()]

  @spec call(
          Plug.Conn.t(),
          nil
          | map()
          | [map()]
          | {:ok, data}
          | {:error, any()}
          | {:only, data, [any]}
          | {:except, data, [any]}
        ) :: Plug.Conn.t()

  @doc "Convenience for controllers"
  def only(data, fields) do
    {:only, data, fields}
  end

  @doc "Convenience for controllers"
  def except(data, fields) do
    {:except, data, fields}
  end

  def init(opts) do
    opts
  end

  def call(conn, nil) do
    call(conn, {:error, :not_found})
  end

  def call(conn, {:ok, coll}) do
    call(conn, coll)
  end

  def call(conn, {:error, :not_found}) do
    send_resp(conn, 400, "Not found")
  end

  def call(conn, {:error, _message}) do
    send_resp(conn, 500, "Internal Server Error")
  end

  def call(conn, list) when is_list(list) do
    json(conn, Enum.map(list, operation(:except, [])))
  end

  def call(conn, map) when is_map(map) do
    json(conn, operation(:except, []).(map))
  end

  def call(conn, {op, list, fields})
      when is_list(list) and op in [:except, :only] do
    call(conn, Enum.map(list, operation(op, fields)))
  end

  def call(conn, {op, map, fields})
      when is_map(map) and op in [:except, :only] do
    call(conn, operation(op, fields).(map))
  end

  def call(conn, {_op, nil, _fields}) do
    call(conn, {:error, :not_found})
  end

  defp operation(:except, fields) do
    &Map.drop(&1, [:__meta__ | [:__struct__ | fields]])
  end

  defp operation(:only, fields) do
    &Map.take(&1, fields)
  end
end

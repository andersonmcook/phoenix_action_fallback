defmodule Paf.Repo do
  use Ecto.Repo,
    otp_app: :paf,
    adapter: Ecto.Adapters.Postgres
end

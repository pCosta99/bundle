defmodule Bundle.Repo do
  use Ecto.Repo,
    otp_app: :bundle,
    adapter: Ecto.Adapters.Postgres
end

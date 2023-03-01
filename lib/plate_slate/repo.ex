defmodule PlateSlate.Repo do
  use Ecto.Repo,
    otp_app: :plate_slate,
    adapter: Ecto.Adapters.Postgres
end

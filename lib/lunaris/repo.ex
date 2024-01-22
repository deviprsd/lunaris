defmodule Lunaris.Repo do
  use Ecto.Repo,
    otp_app: :lunaris,
    adapter: Ecto.Adapters.SQLite3
end

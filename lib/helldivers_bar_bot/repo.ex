defmodule HelldiversBarBot.Repo do
  use Ecto.Repo,
    otp_app: :helldivers_bar_bot,
    adapter: Ecto.Adapters.Postgres
end

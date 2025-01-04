Mimic.copy(Nostrum.Api)
Mimic.copy(Nostrum.Cache.Me)
Mimic.copy(Helldivers2.Api)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(HelldiversBarBot.Repo, :manual)

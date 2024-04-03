defmodule HelldiversBarBotWeb.GuildsLive.Index do
  use HelldiversBarBotWeb, :live_view

  alias HelldiversBarBot.Schema.Guild
  alias HelldiversBarBot.Guilds

  def mount(params, session, socket) do
    socket =
      assign(socket, :guilds, Guilds.list_guilds())
      |> assign(:fields, Guild.__schema__(:fields))

    {:ok, socket}
  end
end

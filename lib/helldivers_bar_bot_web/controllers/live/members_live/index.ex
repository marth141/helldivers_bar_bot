defmodule HelldiversBarBotWeb.MembersLive.Index do
  alias HelldiversBarBot.Schema.Member
  alias HelldiversBarBot.Members
  use HelldiversBarBotWeb, :live_view

  def mount(params, session, socket) do
    socket =
      assign(socket, :members, Members.list_members())
      |> assign(:fields, Member.__schema__(:fields))

    {:ok, socket}
  end
end

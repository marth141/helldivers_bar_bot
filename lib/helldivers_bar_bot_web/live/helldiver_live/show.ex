defmodule HelldiversBarBotWeb.HelldiverLive.Show do
  use HelldiversBarBotWeb, :live_view

  alias HelldiversBarBot.Helldivers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:helldiver, Helldivers.get_helldiver!(id))}
  end

  defp page_title(:show), do: "Show Helldiver"
  defp page_title(:edit), do: "Edit Helldiver"
end

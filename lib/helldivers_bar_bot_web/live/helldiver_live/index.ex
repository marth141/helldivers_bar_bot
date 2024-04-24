defmodule HelldiversBarBotWeb.HelldiverLive.Index do
  use HelldiversBarBotWeb, :live_view

  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :helldivers, Helldivers.list_helldivers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Helldiver")
    |> assign(:helldiver, Helldivers.get_helldiver!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Helldiver")
    |> assign(:helldiver, %Helldiver{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Helldivers")
    |> assign(:helldiver, nil)
  end

  @impl true
  def handle_info({HelldiversBarBotWeb.HelldiverLive.FormComponent, {:saved, helldiver}}, socket) do
    {:noreply, stream_insert(socket, :helldivers, helldiver)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    helldiver = Helldivers.get_helldiver!(id)
    {:ok, _} = Helldivers.delete_helldiver(helldiver)

    {:noreply, stream_delete(socket, :helldivers, helldiver)}
  end
end

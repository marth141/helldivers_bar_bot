defmodule HelldiversBarBotWeb.QuipLive.Index do
  use HelldiversBarBotWeb, :live_view

  alias HelldiversBarBot.Quips
  alias HelldiversBarBot.Quips.Quip

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :quips, Quips.list_quips())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Quip")
    |> assign(:quip, Quips.get_quip!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Quip")
    |> assign(:quip, %Quip{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Quips")
    |> assign(:quip, nil)
  end

  @impl true
  def handle_info({HelldiversBarBotWeb.QuipLive.FormComponent, {:saved, quip}}, socket) do
    {:noreply, stream_insert(socket, :quips, quip)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    quip = Quips.get_quip!(id)
    {:ok, _} = Quips.delete_quip(quip)

    {:noreply, stream_delete(socket, :quips, quip)}
  end
end

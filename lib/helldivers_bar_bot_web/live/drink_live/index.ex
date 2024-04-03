defmodule HelldiversBarBotWeb.DrinkLive.Index do
  use HelldiversBarBotWeb, :live_view

  alias HelldiversBarBot.Drinks
  alias HelldiversBarBot.Drinks.Drink

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :drinks, Drinks.list_drinks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Drink")
    |> assign(:drink, Drinks.get_drink!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Drink")
    |> assign(:drink, %Drink{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Drinks")
    |> assign(:drink, nil)
  end

  @impl true
  def handle_info({HelldiversBarBotWeb.DrinkLive.FormComponent, {:saved, drink}}, socket) do
    {:noreply, stream_insert(socket, :drinks, drink)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    drink = Drinks.get_drink!(id)
    {:ok, _} = Drinks.delete_drink(drink)

    {:noreply, stream_delete(socket, :drinks, drink)}
  end
end

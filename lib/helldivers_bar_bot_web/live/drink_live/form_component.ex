defmodule HelldiversBarBotWeb.DrinkLive.FormComponent do
  use HelldiversBarBotWeb, :live_component

  alias HelldiversBarBot.Drinks

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage drink records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="drink-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:cost]} type="number" label="Cost" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Drink</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{drink: drink} = assigns, socket) do
    changeset = Drinks.change_drink(drink)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"drink" => drink_params}, socket) do
    changeset =
      socket.assigns.drink
      |> Drinks.change_drink(drink_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"drink" => drink_params}, socket) do
    save_drink(socket, socket.assigns.action, drink_params)
  end

  defp save_drink(socket, :edit, drink_params) do
    case Drinks.update_drink(socket.assigns.drink, drink_params) do
      {:ok, drink} ->
        notify_parent({:saved, drink})

        {:noreply,
         socket
         |> put_flash(:info, "Drink updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_drink(socket, :new, drink_params) do
    case Drinks.create_drink(drink_params) do
      {:ok, drink} ->
        notify_parent({:saved, drink})

        {:noreply,
         socket
         |> put_flash(:info, "Drink created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

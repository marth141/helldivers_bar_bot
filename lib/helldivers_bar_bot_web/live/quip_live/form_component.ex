defmodule HelldiversBarBotWeb.QuipLive.FormComponent do
  use HelldiversBarBotWeb, :live_component

  alias HelldiversBarBot.Quips

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage quip records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="quip-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:text]} type="text" label="Text" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Quip</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{quip: quip} = assigns, socket) do
    changeset = Quips.change_quip(quip)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"quip" => quip_params}, socket) do
    changeset =
      socket.assigns.quip
      |> Quips.change_quip(quip_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"quip" => quip_params}, socket) do
    save_quip(socket, socket.assigns.action, quip_params)
  end

  defp save_quip(socket, :edit, quip_params) do
    case Quips.update_quip(socket.assigns.quip, quip_params) do
      {:ok, quip} ->
        notify_parent({:saved, quip})

        {:noreply,
         socket
         |> put_flash(:info, "Quip updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_quip(socket, :new, quip_params) do
    case Quips.create_quip(quip_params) do
      {:ok, quip} ->
        notify_parent({:saved, quip})

        {:noreply,
         socket
         |> put_flash(:info, "Quip created successfully")
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

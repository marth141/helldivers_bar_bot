defmodule HelldiversBarBotWeb.HelldiverLive.FormComponent do
  use HelldiversBarBotWeb, :live_component

  alias HelldiversBarBot.Helldivers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage helldiver records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="helldiver-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:discord_id]} type="text" label="Discord" />
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:messages_sent]} type="number" label="Messages sent" />
        <.input field={@form[:wallet]} type="number" label="Wallet" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Helldiver</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{helldiver: helldiver} = assigns, socket) do
    changeset = Helldivers.change_helldiver(helldiver)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"helldiver" => helldiver_params}, socket) do
    changeset =
      socket.assigns.helldiver
      |> Helldivers.change_helldiver(helldiver_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"helldiver" => helldiver_params}, socket) do
    save_helldiver(socket, socket.assigns.action, helldiver_params)
  end

  defp save_helldiver(socket, :edit, helldiver_params) do
    case Helldivers.update_helldiver(socket.assigns.helldiver, helldiver_params) do
      {:ok, helldiver} ->
        notify_parent({:saved, helldiver})

        {:noreply,
         socket
         |> put_flash(:info, "Helldiver updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_helldiver(socket, :new, helldiver_params) do
    case Helldivers.create_helldiver(helldiver_params) do
      {:ok, helldiver} ->
        notify_parent({:saved, helldiver})

        {:noreply,
         socket
         |> put_flash(:info, "Helldiver created successfully")
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

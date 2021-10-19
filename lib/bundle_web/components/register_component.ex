defmodule BundleWeb.Components.RegisterComponent do
  use BundleWeb, :live_component

  alias Bundle.Accounts
  alias Bundle.Accounts.User

  @impl true
  def mount(socket) do
    changeset = Accounts.change_user_registration(%User{})
    {:ok, assign(socket, changeset: changeset, trigger_submit: false)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def handle_event("register", %{"user" => user_params}, socket) do
    IO.inspect user_params
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(socket, :edit, &1)
          )

        {:noreply, assign(socket, trigger_submit: true)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

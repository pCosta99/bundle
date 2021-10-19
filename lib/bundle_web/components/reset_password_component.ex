defmodule BundleWeb.Components.ResetPasswordComponent do
  use BundleWeb, :live_component

  alias Bundle.Accounts
  alias Bundle.Accounts.User

  @impl true
  def mount(socket) do
    changeset = Accounts.change_user_registration(%User{})
    {:ok, assign(socket, changeset: changeset)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def handle_event("reset", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &Routes.user_reset_password_url(socket, :edit, &1)
      )

      socket =
        socket
        |> put_flash(
          :info,
          "If your email is in our system, you will receive instructions to reset your password shortly."
        )
        |> redirect(to: "/")

      {:noreply, socket}
    end
  end
end

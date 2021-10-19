defmodule BundleWeb.PageLive do
  use BundleWeb, :live_view

  alias Bundle.Accounts
  alias Bundle.Accounts.User

  @impl true
  # IMPROVEMENT: Don't rely on the session to keep track of a failed login?
  def mount(_params, session, socket) do
    changeset = %User{} |> User.login_changeset(%{})

    {:ok,
     assign(socket,
       changeset: changeset,
       trigger_submit: false,
       error_message: Map.get(session, "error")
     )}
  end

  @impl true
  def handle_event("login", %{"user" => user_params}, socket) do
    cs = Accounts.login_user(user_params)
    {:noreply, assign(socket, changeset: cs, trigger_submit: true)}
  end

  @impl true
  def handle_event("close_modal", %{"id" => modal_id}, socket) do
    {:noreply, push_event(socket, "close", %{id: modal_id})}
  end
end

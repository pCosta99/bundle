defmodule BundleWeb.AppLive do
  use BundleWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, trigger_logout: false)}
  end

  @impl true
  def handle_event("logout", _, socket) do
    socket =
      socket
      |> redirect(to: Routes.user_session_path(socket, :delete))

    {:noreply, socket}
  end
end

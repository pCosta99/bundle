defmodule BundleWeb.GithubAuthController do
  @moduledoc """
  Deal with github authentication.
  """
  use BundleWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  alias Bundle.{
    Accounts,
    Accounts.User
  }

  alias BundleWeb.UserAuth

  def request(conn, _params) do
    IO.inspect(conn)
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.get_user_by_email(auth.info.email) do
      nil ->
        conn
        |> put_flash(:error, "Non existing user!")
        |> redirect(to: "/")

      %User{} = user ->
        UserAuth.log_in_user(conn, user)
    end
  end
end

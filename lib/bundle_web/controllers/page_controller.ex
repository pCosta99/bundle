defmodule BundleWeb.PageController do
  use BundleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

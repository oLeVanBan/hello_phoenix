defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def introduction(conn, _params) do
    render conn, "introduction.html"
  end
end

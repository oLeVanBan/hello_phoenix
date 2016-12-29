defmodule HelloPhoenix.Plug.Authenticate do
  import Plug.Conn
  import HelloPhoenix.Router.Helpers
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    current_user = get_session(conn, :current_user)
    if current_user do
      conn
        |> delete_session(:referer_path)
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, 'You need to be signed in to view this page')
        |> put_session(:referer_path, conn.request_path)
        |> redirect(to: session_path(conn, :new))
    end
  end
end

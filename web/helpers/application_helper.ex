defmodule HelloPhoenix.ApplicationHelper do
  alias HelloPhoenix.Repo
  alias HelloPhoenix.User

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Repo.get(User, id)
  end

  def logged_in?(conn) do
    !!current_user(conn)
  end
end

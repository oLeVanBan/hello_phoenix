defmodule HelloPhoenix.SessionController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.User
  alias HelloPhoenix.Repo

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    user = authenticate(session_params)
    if user do
      conn
      |> put_session(:current_user, user.id)
      |> put_flash(:info, "Logged in")
      |> redirect(to: get_session(conn, :referer_path) || "/")
    else
      conn
      |> put_flash(:info, "Wrong email or password")
      |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

  defp authenticate(session_params) do
    user = Repo.get_by(User, user_name: String.downcase(session_params["user_name"]))
    user && Comeonin.Bcrypt.checkpw(session_params["password"], user.crypted_password) && user
  end
end

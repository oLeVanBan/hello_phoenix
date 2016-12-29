require IEx

defmodule HelloPhoenix.LogController do
  use HelloPhoenix.Web, :controller

  plug HelloPhoenix.Plug.Authenticate

  alias HelloPhoenix.Log

  def index(conn, _params) do
    logs = Repo.all(Log)
    render(conn, "index.html", logs: logs)
  end

  def new(conn, _params) do
    changeset = Log.changeset(%Log{}, %{a: 1, b: 0, c: 0})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"log" => log_params}) do
    {a, _} = Integer.parse(log_params["a"])
    {b, _} = Integer.parse(log_params["b"])
    {c, _} = Integer.parse(log_params["c"])
    delta = b * b - 4 * a * c
    log_params =
      case delta do
        del when del < 0 ->
          Map.merge(log_params, %{"result" => "Phương trình vô nghiệm"})
        del when del == 0 ->
          Map.merge(log_params, %{"result" => "Phương trình có nghiệm kép x1 = x2 = #{-b / (2 * a)}"})
        _ ->
          sqrt_delta = :math.sqrt(delta)
          x1 = (-b + sqrt_delta) / (2 * a)
          x2 = (-b - sqrt_delta) / (2 * a)
          Map.merge(log_params, %{"result" => "Phương trình có 2 nghiệm x1 = #{x1} và x2 = #{x2}"})
      end
    changeset = Log.changeset(%Log{}, log_params)
    case Repo.insert(changeset) do
      {:ok, log} ->
        conn
        |> put_flash(:info, "Log created successfully.")
        |> redirect(to: log_path(conn, :show, log))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)
    render(conn, "show.html", log: log)
  end

  def edit(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)
    changeset = Log.changeset(log)
    render(conn, "edit.html", log: log, changeset: changeset)
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    log = Repo.get!(Log, id)
    {a, _} = Integer.parse(log_params["a"])
    {b, _} = Integer.parse(log_params["b"])
    {c, _} = Integer.parse(log_params["c"])
    delta = b * b - 4 * a * c
    log_params =
      case delta do
        del when del < 0 ->
          Map.merge(log_params, %{"result" => "Phương trình vô nghiệm"})
        del when del == 0 ->
          Map.merge(log_params, %{"result" => "Phương trình có nghiệm kép x1 = x2 = #{-b / (2 * a)}"})
        _ ->
          sqrt_delta = :math.sqrt(delta)
          x1 = (-b + sqrt_delta) / (2 * a)
          x2 = (-b - sqrt_delta) / (2 * a)
          Map.merge(log_params, %{"result" => "Phương trình có 2 nghiệm x1 = #{x1} và x2 = #{x2}"})
      end
    changeset = Log.changeset(log, log_params)

    case Repo.update(changeset) do
      {:ok, log} ->
        conn
        |> put_flash(:info, "Log updated successfully.")
        |> redirect(to: log_path(conn, :show, log))
      {:error, changeset} ->
        render(conn, "edit.html", log: log, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(log)

    conn
    |> put_flash(:info, "Log deleted successfully.")
    |> redirect(to: log_path(conn, :index))
  end
end

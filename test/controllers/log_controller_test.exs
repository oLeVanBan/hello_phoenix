defmodule HelloPhoenix.LogControllerTest do
  use HelloPhoenix.ConnCase

  alias HelloPhoenix.Log
  @valid_attrs %{a: 42, b: 42, c: 42, result: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, log_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing logs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, log_path(conn, :new)
    assert html_response(conn, 200) =~ "New log"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, log_path(conn, :create), log: @valid_attrs
    assert redirected_to(conn) == log_path(conn, :index)
    assert Repo.get_by(Log, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, log_path(conn, :create), log: @invalid_attrs
    assert html_response(conn, 200) =~ "New log"
  end

  test "shows chosen resource", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = get conn, log_path(conn, :show, log)
    assert html_response(conn, 200) =~ "Show log"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, log_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = get conn, log_path(conn, :edit, log)
    assert html_response(conn, 200) =~ "Edit log"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = put conn, log_path(conn, :update, log), log: @valid_attrs
    assert redirected_to(conn) == log_path(conn, :show, log)
    assert Repo.get_by(Log, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = put conn, log_path(conn, :update, log), log: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit log"
  end

  test "deletes chosen resource", %{conn: conn} do
    log = Repo.insert! %Log{}
    conn = delete conn, log_path(conn, :delete, log)
    assert redirected_to(conn) == log_path(conn, :index)
    refute Repo.get(Log, log.id)
  end
end

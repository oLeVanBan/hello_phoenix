defmodule HelloPhoenix.LogTest do
  use HelloPhoenix.ModelCase

  alias HelloPhoenix.Log

  @valid_attrs %{a: 42, b: 42, c: 42, result: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Log.changeset(%Log{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Log.changeset(%Log{}, @invalid_attrs)
    refute changeset.valid?
  end
end

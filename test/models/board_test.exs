defmodule Trelloclone.BoardTest do
  use Trelloclone.ModelCase

  alias Trelloclone.Board

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Board.changeset(%Board{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Board.changeset(%Board{}, @invalid_attrs)
    refute changeset.valid?
  end
end

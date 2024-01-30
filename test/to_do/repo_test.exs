defmodule ToDo.RepoTest do
  use ToDo.DataCase, async: true

  describe "cast_id/1" do
    test "returns ok for valid id" do
      id = Ecto.UUID.generate()
      assert Repo.cast_id(id) == {:ok, id}
    end

    test "returns error for invalid id" do
      assert Repo.cast_id("invalid_id") == {:error, :invalid_id}
      assert Repo.cast_id(%{}) == {:error, :invalid_id}
      assert Repo.cast_id([]) == {:error, :invalid_id}
    end

    # Since both binaries and strings are represent as binaries,
    # this means some strings you may not expect are actually
    # also valid UUIDs in their binary form. (Ref. UUID.cast/1 documentation)
    test "returns error for false positive uuid" do
      assert Repo.cast_id("warehouse worker") == {:error, :invalid_id}
    end
  end
end

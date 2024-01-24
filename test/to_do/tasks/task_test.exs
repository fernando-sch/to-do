defmodule ToDo.Tasks.TaskTest do
  use ToDo.DataCase, async: true

  alias ToDo.Tasks.Task
  alias ToDo.Factory

  describe "changeset/2" do
    test "validates required fields" do
      changeset = Task.changeset(%Task{}, %{})

      refute changeset.valid?
      assert errors_on(changeset) == %{title: ["can't be blank"]}
    end

    test "returns valid changeset" do
      attrs = Factory.params_for(:task)

      changeset = Task.changeset(%Task{}, attrs)
      assert changeset.valid?
    end
  end
end

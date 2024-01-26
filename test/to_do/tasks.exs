defmodule ToDo.TasksTest do
  use ToDo.DataCase, async: true

  alias ToDo.Factory
  alias ToDo.Tasks
  alias ToDo.Tasks.Task

  describe "create_task/1" do
    test "creates a task" do
      attrs = Factory.params_for(:task)
      assert {:ok, %Task{}} = Tasks.create_task(attrs)
    end

    test "returns error for empty attrs" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(%{})
    end
  end
end

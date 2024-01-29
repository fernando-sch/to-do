defmodule ToDo.TasksTest do
  use ToDo.DataCase, async: true

  alias ToDo.Factory
  alias ToDo.Tasks
  alias ToDo.Tasks.Task

  describe "create_task/1" do
    test "creates a task" do
      attrs = Factory.params_for(:task)
      assert Tasks.create_task(attrs) == {:ok, %Task{}}
    end

    test "returns error for empty attrs" do
      assert Tasks.create_task(%{}) == {:error, %Ecto.Changeset{}}
    end
  end

  describe "get_task/1" do
    test "returns task" do
      task = Factory.insert(:task)
      assert Tasks.get_task(task.id) == {:ok, task}
    end

    test "returns error for invalid id" do
      assert Tasks.get_task("invalid_id") == {:error, :invalid_id}
    end

    test "returns error if task don't exist" do
      assert Tasks.get_task(Ecto.UUID.generate()) == {:error, :not_found}
    end
  end
end

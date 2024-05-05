defmodule ToDo.TasksTest do
  use ToDo.DataCase, async: true

  alias ToDo.Factory
  alias ToDo.Tasks
  alias ToDo.Tasks.Task

  describe "list_tasks/0" do
    test "returns a list of tasks" do
      tasks = Factory.insert_list(4, :task)
      assert Tasks.list_tasks() == tasks
    end
  end

  describe "create_task/1" do
    test "creates a task" do
      attrs = Factory.params_for(:task)
      assert {:ok, %Task{}} = Tasks.create_task(attrs)
    end

    test "returns error for empty attrs" do
      {:error, changeset} = Tasks.create_task(%{})

      assert errors_on(changeset) == %{title: ["can't be blank"]}
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

  describe "update_task/1" do
    test "updates task" do
      task = Factory.insert(:task, title: "Task Title", description: nil)
      attrs = %{title: "New Task Title", description: "Task description"}
      {:ok, task} = Tasks.update_task(task, attrs)

      assert task.title == attrs.title
      assert task.description == attrs.description
    end

    test "completes task" do
      task = Factory.insert(:task, is_completed: false)
      attrs = %{is_completed: true}
      {:ok, task} = Tasks.update_task(task, attrs)

      assert task.is_completed
    end

    test "returns error for invalid update" do
      task = Factory.insert(:task, title: "Task Title")
      {:error, changeset} = Tasks.update_task(task, %{title: nil})

      assert errors_on(changeset) == %{title: ["can't be blank"]}
    end
  end

  describe "delete_task/1" do
    test "deletes task" do
      task = Factory.insert(:task)
      {:ok, _del_task} = Tasks.delete_task(task)
      refute Repo.exists?(Task, id: task.id)
    end
  end
end

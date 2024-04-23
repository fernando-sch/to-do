defmodule ToDoWeb.Tasks.TaskControllerTest do
  use ToDoWeb.ConnCase, async: true

  alias ToDo.Tasks.Task
  alias ToDo.Factory
  alias ToDo.Repo

  describe "index/2" do
    test "returns 200 listing all tasks" do
      tasks = Factory.insert_list(4, :task)
      conn = get(build_conn(), "/api/tasks")
      body = json_response(conn, 200)
      assert body["data"] == build_index_body(tasks)
    end
  end

  describe "create/2" do
    test "returns 201 with created task" do
      task_params = Factory.params_for(:task)
      conn = post(build_conn(), "/api/tasks", task_params)
      assert json_response(conn, 201)
    end

    test "returns 422 for invalid task creation" do
      conn = post(build_conn(), "/api/tasks", %{})
      body = json_response(conn, 422)
      assert body["errors"] == %{"detail" => %{"title" => ["can't be blank"]}}
    end
  end

  describe "update/2" do
    test "returns 200 with updated task" do
      task = Factory.insert(:task)
      task_params = %{"title" => "Some cool title"}
      conn = patch(build_conn(), "/api/tasks/#{task.id}", task_params)
      body = json_response(conn, 200)
      assert body["data"] == build_show_body(task, task_params)
    end

    test "returns 404 for not found task" do
      task_params = %{"title" => "Some cool title"}
      conn = patch(build_conn(), "/api/tasks/#{Ecto.UUID.generate()}", task_params)
      body = json_response(conn, 404)
      assert body["errors"] == %{"detail" => "Not Found"}
    end

    test "retuns 422 for invalid task id" do
      task_params = %{"title" => "Some cool title"}
      conn = patch(build_conn(), "/api/tasks/invalid_id", task_params)
      body = json_response(conn, 422)
      assert body["errors"] == %{"detail" => "Invalid ID"}
    end

    test "returns 422 for invalid update" do
      task = Factory.insert(:task)
      task_params = %{"title" => nil}
      conn = patch(build_conn(), "/api/tasks/#{task.id}", task_params)
      body = json_response(conn, 422)
      assert body["errors"] == %{"detail" => %{"title" => ["can't be blank"]}}
    end
  end

  describe "delete/2" do
    test "returns 204 deleting a task" do
      task = Factory.insert(:task)
      conn = delete(build_conn(), "/api/tasks/#{task.id}")
      assert response(conn, 204)
      refute Repo.exists?(Task, id: task.id)
    end

    test "returns 404 for not found task" do
      conn = delete(build_conn(), "/api/tasks/#{Ecto.UUID.generate()}")
      body = json_response(conn, 404)
      assert body["errors"] == %{"detail" => "Not Found"}
    end

    test "returns 422 for invalid task id" do
      conn = delete(build_conn(), "/api/tasks/invalid_id")
      body = json_response(conn, 422)
      assert body["errors"] == %{"detail" => "Invalid ID"}
    end
  end

  ## Helpers

  defp build_index_body(tasks) do
    Enum.map(tasks, &build_show_body/1)
  end

  defp build_show_body(task, custom_attrs \\ %{}) do
    %{
      "id" => task.id,
      "title" => task.title,
      "description" => task.description,
      "is_completed" => task.is_completed
    }
    |> Map.merge(custom_attrs)
  end
end

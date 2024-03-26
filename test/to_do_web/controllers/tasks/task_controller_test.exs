defmodule ToDoWeb.Tasks.TaskControllerTest do
  use ToDoWeb.ConnCase, async: true

  alias ToDo.Factory

  describe "create/2" do
    test "returns 201 with created task" do
      task_params = Factory.params_for(:task)
      conn = post(build_conn(), "/api/tasks", task_params)
      body = json_response(conn, 201)
      assert body["data"] == build_show_body(task_params)
    end

    test "returns 422 for invalid task creation" do
      conn = post(build_conn(), "/api/tasks", %{})
      body = json_response(conn, 422)
      assert body["errors"] == %{"title" => ["can't be blank"]}
    end
  end

  ## Helpers

  defp build_show_body(task) do
    %{
      "title" => task.title,
      "description" => task.description,
      "is_completed?" => task.is_completed?
    }
  end
end

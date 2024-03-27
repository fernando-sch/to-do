defmodule ToDoWeb.Tasks.TaskController do
  use ToDoWeb, :controller

  action_fallback ToDoWeb.FallbackController

  alias ToDo.Tasks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()

    render(conn, :index, tasks: tasks)
  end

  def create(conn, params) do
    with {:ok, task} <- Tasks.create_task(params) do
      conn
      |> put_status(201)
      |> render(:show, task: task)
    end
  end

  def update(conn, %{"id" => task_id} = params) do
    with {:ok, task} <- Tasks.get_task(task_id),
         {:ok, task} <- Tasks.update_task(task, params) do
      render(conn, :show, task: task)
    end
  end

  def delete(conn, %{"id" => task_id}) do
    with {:ok, task} <- Tasks.get_task(task_id),
         {:ok, _} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end

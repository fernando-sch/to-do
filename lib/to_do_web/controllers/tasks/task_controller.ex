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
end

defmodule ToDoWeb.Tasks.TaskController do
  use ToDoWeb, :controller

  action_fallback ToDoWeb.FallbackController

  alias ToDo.Tasks

  def create(conn, params) do
    with {:ok, task} <- Tasks.create_task(params) do
      conn
      |> put_status(201)
      |> render(:show, task: task)
    end
  end
end

defmodule ToDoWeb.Tasks.TaskJSON do
  alias ToDo.Tasks.Task

  def index(%{tasks: tasks}) do
    %{data: Enum.map(tasks, &data/1)}
  end

  def show(%{task: task}) do
    %{data: data(task)}
  end

  def data(%Task{} = task) do
    %{
      title: task.title,
      description: task.description,
      is_completed: task.is_completed
    }
  end
end

defmodule ToDo.Tasks do
  @moduledoc """
    Module with all Task related functions
  """

  alias ToDo.Tasks.Task
  alias ToDo.Repo

  @spec create_task(map()) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def create_task(%{} = attrs) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end
end

defmodule ToDo.Factory do
  @moduledoc """
    Factory of fixtures using ex-machina lib, for tests
  """
  use ExMachina.Ecto, repo: Teaching.Repo

  alias ToDo.Tasks.Task

  def task_factory do
    %Task{
      title: sequence("title_"),
      description: sequence("fancy_description_"),
      is_completed?: false
    }
  end
end

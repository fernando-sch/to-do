defmodule ToDo.Tasks.Task do
  @moduledoc """
    Schema for Task
  """

  use Ecto.Schema

  @type t :: %__MODULE__{
          id: nil | Ecto.UUID.t(),
          title: nil | String.t(),
          description: nil | String.t(),
          is_completed?: boolean()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field(:title, :string)
    field(:description, :string)
    field(:is_completed?, :boolean, default: false)

    timestamps()
  end
end

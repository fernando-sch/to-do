defmodule ToDo.Tasks.Task do
  @moduledoc """
    Schema for Task
  """

  use Ecto.Schema
  import Ecto.Changeset

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

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = task, %{} = attrs) do
    fields = ~w(title description)a
    required_fields = ~w(title)a

    task
    |> cast(attrs, fields)
    |> validate_required(required_fields)
  end
end

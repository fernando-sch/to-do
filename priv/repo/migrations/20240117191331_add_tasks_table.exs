defmodule ToDo.Repo.Migrations.AddTasksTable do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add(:id, :uuid, primary_key: true, null: false)
      add(:title, :string, null: false)
      add(:description, :string)
      add(:is_done?, :boolean, default: false, null: false)

      timestamps(type: :naive_datetime_usec)
    end
  end
end

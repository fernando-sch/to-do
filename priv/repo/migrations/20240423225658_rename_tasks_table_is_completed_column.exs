defmodule ToDo.Repo.Migrations.RenameTasksTableIsCompletedColumn do
  use Ecto.Migration

  def change do
    rename(table(:tasks), :is_completed?, to: :is_completed)
  end
end

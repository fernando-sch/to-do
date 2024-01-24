defmodule ToDo.Repo.Migrations.RenameTasksTableIsDoneColumn do
  use Ecto.Migration

  def change do
    rename(table(:tasks), :is_done?, to: :is_completed?)
  end
end

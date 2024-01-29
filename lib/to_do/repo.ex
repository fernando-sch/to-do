defmodule ToDo.Repo do
  use Ecto.Repo,
    otp_app: :to_do,
    adapter: Ecto.Adapters.Postgres

  @spec cast_id(any()) :: {:ok, Ecto.UUID.t()} | {:error, :invalid_id}
  def cast_id(id) do
    case Ecto.UUID.cast(id) do
      {:ok, ^id} -> {:ok, id}
      _ -> {:error, :invalid_id}
    end
  end
end

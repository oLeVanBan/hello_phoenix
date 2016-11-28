defmodule HelloPhoenix.Repo.Migrations.CreateLog do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :a, :integer
      add :b, :integer
      add :c, :integer
      add :result, :text

      timestamps()
    end

  end
end

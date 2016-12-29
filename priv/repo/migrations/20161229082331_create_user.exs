defmodule HelloPhoenix.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string
      add :crypted_password, :string

      timestamps()
    end
    create unique_index(:users, [:user_name])

  end
end

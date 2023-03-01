defmodule PlateSlate.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :password, :string, null: false
      add :role, :string

      timestamps()
    end

    create unique_index(:users, [:email, :role])
  end
end

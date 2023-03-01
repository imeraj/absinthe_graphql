defmodule PlateSlate.Repo.Migrations.CreateItemTags do
  use Ecto.Migration

  def change do
    create table(:item_tags) do
      add :name, :string, null: false
      add :description, :string

      timestamps()
    end
  end
end

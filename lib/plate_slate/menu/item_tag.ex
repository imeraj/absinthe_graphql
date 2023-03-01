defmodule PlateSlate.Menu.ItemTag do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlateSlate.Menu.ItemTag

  schema "item_tags" do
    field :description
    field :name, :string

    many_to_many :items, PlateSlate.Menu.Item, join_through: "items_taggings"

    timestamps()
  end

  @doc false
  def changeset(%ItemTag{} = item_tag, attrs) do
    item_tag
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end

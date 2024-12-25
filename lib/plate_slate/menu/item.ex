defmodule PlateSlate.Menu.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlateSlate.Menu.Item

  schema "items" do
    field :added_on, :date, default: NaiveDateTime.to_date(NaiveDateTime.utc_now())
    field :description, :string
    field :name, :string
    field :price, :decimal

    embeds_many :allergy_info, AllergyInfo do
      field :allergen, :string
      field :severity, :string
    end

    belongs_to :category, PlateSlate.Menu.Category
    many_to_many :tags, PlateSlate.Menu.ItemTag, join_through: "items_taggings"

    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:name, :description, :price, :category_id])
    |> cast_embed(:allergy_info)
    |> validate_required([:name, :price, :category_id])
    |> foreign_key_constraint(:category, name: "items_category_id_fkey")
    |> unique_constraint(:name)
  end
end

defmodule PlateSlate.Ordering.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :price, :decimal
    field :name, :string
    field :quantity, :integer
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:price, :name, :quantity])
    |> validate_required([:price, :name, :quantity])
    |> validate_number(:quantity, greater_than: 0, less_than: 10)
    |> validate_number(:price, greater_than: 0)
  end
end

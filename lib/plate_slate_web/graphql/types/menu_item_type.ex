defmodule PlateSlateWeb.Graphql.Types.MenuItemType do
  @moduledoc false

  use Absinthe.Schema.Notation

  import_types(PlateSlateWeb.Graphql.Types.Scalars.Date)
  import_types(PlateSlateWeb.Graphql.Types.Scalars.Decimal)

  @desc "A menu item"
  object :menu_item do
    field :id, non_null(:id), description: "Menu item ID"
    field :name, non_null(:string), description: "Menu item name"
    field :description, :string, description: "Menu item description"
    field :price, non_null(:decimal), description: "Menu item price"
    field :added_on, non_null(:date), description: "Menu item added on date"
  end
end

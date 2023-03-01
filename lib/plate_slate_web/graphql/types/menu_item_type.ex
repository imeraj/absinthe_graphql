defmodule PlateSlateWeb.Graphql.Types.MenuItemType do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "A menu item"
  object :menu_item do
    field :id, :id, description: "Menu item ID"
    field :name, :string, description: "Menu item name"
    field :description, :string, description: "Menu item description"
  end
end

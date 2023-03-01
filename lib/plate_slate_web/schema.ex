defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  alias Graphql.Resolvers

  query do
    field :menu_items, list_of(:menu_item), description: "List of available menu items" do
      arg(:matching, :string, description: "Filters for menu items")
      resolve(&Resolvers.Menu.menu_items/3)
    end
  end

  @desc "A menu item"
  object :menu_item do
    field :id, :id, description: "Menu item ID"
    field :name, :string, description: "Menu item name"
    field :description, :string, description: "Menu item description"
  end
end

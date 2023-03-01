defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  alias PlateSlate.{Menu, Repo}

  query do
    field :menu_items, list_of(:menu_item), description: "List of available menu items" do
      resolve(fn _, _, _ ->
        {:ok, Repo.all(Menu.Item)}
      end)
    end
  end

  @desc "A menu item"
  object :menu_item do
    field :id, :id, description: "Menu item ID"
    field :name, :string, description: "Menu item name"
    field :description, :string, description: "Menu item description"
  end
end

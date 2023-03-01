defmodule PlateSlateWeb.Graphql.Types.MenuItemType do
  @moduledoc false

  import Ecto.Query, warn: false
  import Absinthe.Resolution.Helpers, only: [async: 1]

  use Absinthe.Schema.Notation

  @desc "A menu item"
  object :menu_item do
    field :id, non_null(:id), description: "Menu item ID"
    field :name, non_null(:string), description: "Menu item name"
    field :description, :string, description: "Menu item description"
    field :price, non_null(:decimal), description: "Menu item price"
    field :added_on, non_null(:date), description: "Menu item added on date"

    @doc """
    Async version
    """

    #    field :category, :category do
    #      resolve(fn menu_item, _, _ ->
    #        async(fn ->
    #          query = Ecto.assoc(menu_item, :category)
    #          {:ok, PlateSlate.Repo.one(query)}
    #        end)
    #      end)
    #    end

    @doc """
    Batch version
    """
    field :category, :category do
      resolve(fn menu_item, _, _ ->
        batch({PlateSlate.Menu, :categories_by_id}, menu_item.category_id, fn
          categories ->
            {:ok, Map.get(categories, menu_item.category_id)}
        end)
      end)
    end
  end
end

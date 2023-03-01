defmodule PlateSlateWeb.Graphql.Queries.MenuQuery do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.MenuResolver

  @desc "Get a menu of items"
  object :menu_query do
    field :menu, :menu_payload do
      arg(:filter, :menu_item_filter, description: "Filter for menu items")

      arg(:order, :sort_order,
        default_value: :asc,
        description: "Menu items sort order. Default ASC"
      )

      resolve(&MenuResolver.menu_items/3)
    end
  end
end

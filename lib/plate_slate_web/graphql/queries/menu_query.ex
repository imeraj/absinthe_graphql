defmodule PlateSlateWeb.Graphql.Queries.MenuQuery do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.MenuResolver

  import_types(PlateSlateWeb.Graphql.InputTypes.MenuItemFilter)
  import_types(PlateSlateWeb.Graphql.Payloads.MenuPayload)

  object :menu_query do
    @desc "Get a menu of items"
    field :menu, :menu_payload do
      arg(:filter, :menu_item_filter, description: "Filters for menu items")
      resolve(&MenuResolver.menu_items/3)
    end
  end
end

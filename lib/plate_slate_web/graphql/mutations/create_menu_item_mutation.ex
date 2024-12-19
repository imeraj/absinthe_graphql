defmodule PlateSlateWeb.Graphql.Mutations.CreateMenuItemMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  import_types(PlateSlateWeb.Graphql.Payloads.CreateMenuItemPayload)
  import_types(PlateSlateWeb.Graphql.InputTypes.CreateMenuItemInput)

  alias PlateSlateWeb.Graphql.Resolvers.CreateMenuItemResolver

  object :create_menu_item_mutation do
    @desc "Create menu item"
    field :create_menu_item, :create_menu_item_payload do
      arg(:input, non_null(:create_menu_item_input))
      middleware(PlateSlateWeb.Graphql.Middlewares.Authorize, "employee")
      resolve(&CreateMenuItemResolver.create_menu_item/3)
    end
  end
end

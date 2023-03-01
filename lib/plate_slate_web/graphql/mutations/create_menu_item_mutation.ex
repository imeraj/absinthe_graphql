defmodule PlateSlateWeb.Graphql.Mutations.CreateMenuItemMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.CreateMenuItemResolver

  object :create_menu_item_mutation do
    @desc "Create menu item"
    field :create_menu_item, :create_menu_item_payload do
      arg(:input, non_null(:create_menu_item_input))
      resolve(&CreateMenuItemResolver.create_menu_item/3)
    end
  end
end

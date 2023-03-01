defmodule PlateSlateWeb.Graphql.Payloads.CreateMenuItemPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Menu Item payload"
  union :create_menu_item_payload do
    types([:menu_item, :errors])

    resolve_type(fn
      %PlateSlate.Menu.Item{}, _ ->
        :menu_item

      %{errors: _}, _ ->
        :errors

      _, _ ->
        nil
    end)
  end
end

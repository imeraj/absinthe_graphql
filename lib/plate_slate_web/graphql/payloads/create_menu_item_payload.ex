defmodule PlateSlateWeb.Graphql.Payloads.CreateMenuItemPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Menu Item payload"
  object :create_menu_item_payload do
    field :menu_item, :menu_item do
      resolve(fn menu_item, _, _ ->
        {:ok, menu_item}
      end)
    end
  end
end

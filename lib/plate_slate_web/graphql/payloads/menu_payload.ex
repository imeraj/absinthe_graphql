defmodule PlateSlateWeb.Graphql.Payloads.MenuPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Menu payload"
  object :menu_payload do
    field :menu_items, non_null(list_of(:menu_item)) do
      resolve(fn menu_item, _, _ ->
        {:ok, menu_item}
      end)
    end
  end
end

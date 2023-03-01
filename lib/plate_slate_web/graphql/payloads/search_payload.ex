defmodule PlateSlateWeb.Graphql.Payloads.SearchPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Search payload"
  union :search_payload do
    types([:menu_item, :category])

    resolve_type(fn
      %PlateSlate.Menu.Item{}, _ ->
        :menu_item

      %PlateSlate.Menu.Category{}, _ ->
        :category

      _, _ ->
        nil
    end)
  end
end

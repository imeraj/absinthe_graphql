defmodule PlateSlateWeb.Graphql.Payloads.PlaceOrderPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Place order payload"
  union :place_order_payload do
    types([:order, :errors])

    resolve_type(fn
      %PlateSlate.Ordering.Order{}, _ ->
        :order

      %{errors: _}, _ ->
        :errors

      _, _ ->
        nil
    end)
  end
end

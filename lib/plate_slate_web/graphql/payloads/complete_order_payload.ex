defmodule PlateSlateWeb.Graphql.Payloads.CompleteOrderPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Complete order payload"
  union :complete_order_payload do
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

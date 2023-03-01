defmodule PlateSlateWeb.Graphql.Payloads.ReadyOrderPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Ready order payload"
  union :ready_order_payload do
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

defmodule PlateSlateWeb.Graphql.Mutations.PlaceOrderMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  import_types(PlateSlateWeb.Graphql.Payloads.PlaceOrderPayload)
  import_types(PlateSlateWeb.Graphql.InputTypes.PlaceOrderInput)

  alias PlateSlateWeb.Graphql.Resolvers.PlaceOrderResolver

  object :place_order_mutation do
    @desc "Place order"
    field :place_order, :place_order_payload do
      arg(:input, non_null(:place_order_input))
      middleware(PlateSlateWeb.Graphql.Middlewares.Authorize, :any)
      resolve(&PlaceOrderResolver.place_order/3)
    end
  end
end

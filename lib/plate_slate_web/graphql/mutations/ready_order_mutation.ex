defmodule PlateSlateWeb.Graphql.Mutations.ReadyOrderMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.ReadyOrderResolver

  object :ready_order_mutation do
    @desc "Ready order"
    field :ready_order, :ready_order_payload do
      arg(:id, non_null(:id))
      resolve(&ReadyOrderResolver.ready_order/3)
    end
  end
end

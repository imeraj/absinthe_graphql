defmodule PlateSlateWeb.Graphql.Mutations.CompleteOrderMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.CompleteOrderResolver

  object :complete_order_mutation do
    @desc "Complete order"
    field :complete_order, :complete_order_payload do
      arg(:id, non_null(:id))
      resolve(&CompleteOrderResolver.complete_order/3)
    end
  end
end

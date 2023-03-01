defmodule PlateSlateWeb.Graphql.Mutations.NewOrderSubscription do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.NewOrderResolver

  object :new_order_subscription do
    @desc "New order subscription"
    field :new_order, :order do
      config(fn _args, _info ->
        {:ok, topic: "*"}
      end)

      # this is not required here but if custom resolver is needed,
      # this is how it's implemented
      resolve(&NewOrderResolver.new_order/3)
    end
  end
end

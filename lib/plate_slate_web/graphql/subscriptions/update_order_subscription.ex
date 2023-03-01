defmodule PlateSlateWeb.Graphql.Mutations.UpdateOrderSubscription do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias PlateSlate.Ordering.Order

  object :update_order_subscription do
    @desc "Update order subscription"
    field :update_order, :order do
      arg(:id, non_null(:id))

      config(fn args, _info ->
        {:ok, topic: args.id}
      end)

      trigger([:ready_order, :complete_order],
        topic: fn
          %Order{} = order -> [order.id]
          _ -> []
        end
      )

      resolve(fn %Order{} = order, _, _ ->
        {:ok, order}
      end)
    end
  end
end

defmodule PlateSlateWeb.Graphql.Subscriptions.NewOrderSubscription do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.NewOrderResolver

  object :new_order_subscription do
    @desc "New order subscription"
    field :new_order, :order do
      config(fn _args, %{context: context} ->
        case context[:current_user] do
          %{role: "customer", id: id} ->
            {:ok, topic: id}

          %{role: "employee"} ->
            {:ok, topic: "*"}

          _ ->
            {:error, "unauthorized"}
        end
      end)

      resolve(&NewOrderResolver.new_order/3)
    end
  end
end

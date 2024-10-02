defmodule PlateSlateWeb.Graphql.Resolvers.PlaceOrderResolver do
  @moduledoc false

  alias PlateSlate.Ordering

  def place_order(_, %{input: params}, %{context: context}) do
    params =
      case context[:current_user] do
        %{role: _role, id: id} ->
          Map.put(params, :customer_id, id)

        _ ->
          params
      end

    with {:ok, order} <- Ordering.create_order(params) do
      Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, order,
        new_order: [order.customer_id, "*"]
      )

      # this is because order is a basic type. We don't need to return a map
      {:ok, order}
    end
  end
end

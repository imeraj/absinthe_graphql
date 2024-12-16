defmodule PlateSlateWeb.Graphql.Resolvers.CompleteOrderResolver do
  @moduledoc false

  alias PlateSlate.Ordering
  alias PlateSlate.Ordering.Order

  def complete_order(_, %{id: id}, _) do
    with %Order{} = order <- Ordering.get_order(id),
         {:ok, order} <- Ordering.update_order(order, %{state: "complete"}) do
      {:ok, order}
    else
      nil -> {:error, %{key: "id", message: "invalid ID"}}
    end
  end
end

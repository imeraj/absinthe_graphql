defmodule PlateSlateWeb.Graphql.Resolvers.ReadyOrderResolver do
  @moduledoc false

  alias PlateSlate.Ordering
  alias PlateSlate.Ordering.Order

  def ready_order(_, %{id: id}, _) do
    with %Order{} = order <- Ordering.get_order(id),
         {:ok, order} <- Ordering.update_order(order, %{state: "ready"}) do
      {:ok, order}
    else
      nil -> {:error, "invalid ID"}
    end
  end
end

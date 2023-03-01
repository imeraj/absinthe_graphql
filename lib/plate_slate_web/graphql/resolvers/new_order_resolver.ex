defmodule PlateSlateWeb.Graphql.Resolvers.NewOrderResolver do
  @moduledoc false

  def new_order(order, _, _) do
    IO.inspect(order, label: "New order")
    {:ok, order}
  end
end

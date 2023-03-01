defmodule PlateSlateWeb.Graphql.Resolvers.NewOrderResolver do
  @moduledoc false

  def new_order(order, _, _) do
    {:ok, order}
  end
end

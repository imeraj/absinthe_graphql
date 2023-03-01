defmodule PlateSlateWeb.Graphql.Resolvers.PlaceOrderResolver do
  @moduledoc false

  alias PlateSlateWeb.Utils
  alias PlateSlate.Ordering

  def place_order(_, %{input: params}, _) do
    case Ordering.create_order(params) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, %{errors: Utils.transform_errors(changeset)}}

      {:ok, order} ->
        Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, order, new_order: "*")

        # this is because menu_item is a basic type. We don't need to return a map
        {:ok, order}
    end
  end
end

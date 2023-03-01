defmodule PlateSlateWeb.Graphql.Resolvers.ReadyOrderResolver do
  @moduledoc false

  alias PlateSlateWeb.Utils
  alias PlateSlate.Ordering

  def ready_order(_, %{id: id}, _) do
    order = Ordering.get_order!(id)

    case Ordering.update_order(order, %{state: "ready"}) do
      {:ok, order} ->
        {:ok, order}

      {:error, changeset} ->
        {:ok, %{errors: Utils.transform_errors(changeset)}}
    end
  end
end

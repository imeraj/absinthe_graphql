defmodule PlateSlate.Ordering do
  @moduledoc """
  The Ordering context.
  """

  import Ecto.Query, warn: false

  alias PlateSlate.Repo
  alias PlateSlate.Menu.Item
  alias PlateSlate.Ordering.Order

  def create_order(attrs \\ %{}) do
    attrs = Map.update(attrs, :items, [], &build_items/1)

    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  defp build_items(items) do
    for item <- items do
      case PlateSlate.Menu.get_item(item.menu_item_id) do
        %Item{} = menu_item ->
          %{name: menu_item.name, quantity: item.quantity, price: menu_item.price}

        nil ->
          %{}
      end
    end
  end
end

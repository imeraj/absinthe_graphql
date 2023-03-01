defmodule PlateSlate.OrderingTest do
  use PlateSlate.DataCase

  alias PlateSlate.Ordering
  alias PlateSlate.Ordering.Order
  alias PlateSlate.Repo

  setup do
    PlateSlate.Seeds.run()
  end

  describe "orders" do
    test "create_order/1 with valid data creates an order" do
      chai = Repo.get_by!(PlateSlate.Menu.Item, name: "Masala Chai")
      fries = Repo.get_by!(PlateSlate.Menu.Item, name: "French Fries")

      attrs = %{
        ordered_at: NaiveDateTime.local_now(),
        state: "created",
        items: [
          %{menu_item_id: chai.id, quantity: 1},
          %{menu_item_id: fries.id, quantity: 1}
        ]
      }

      assert {:ok, %Order{} = order} = Ordering.create_order(attrs)

      assert Enum.map(order.items, &Map.take(&1, [:name, :quantity, :price])) ==
               [
                 %{name: "Masala Chai", price: chai.price, quantity: 1},
                 %{name: "French Fries", price: fries.price, quantity: 1}
               ]
    end
  end
end

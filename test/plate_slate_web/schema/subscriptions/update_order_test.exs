defmodule PlateSlateWeb.Schema.Subscriptions.UpdateOrderTest do
  use PlateSlateWeb.SubscriptionCase

  setup do
    PlateSlate.Seeds.run()
  end

  @subscription """
  subscription ($id: ID! ){
    updateOrder(id: $id) { state }
  }
  """

  @mutation """
  mutation($id: ID!) {
    readyOrder(id: $id) {
      ... on Order {
        state
      }
      ... on Errors {
        errors {
          key
          message
        }
      }
    }
  }
  """

  defp menu_item(name), do: PlateSlate.Repo.get_by!(PlateSlate.Menu.Item, name: name)

  test "subscribe to order updates", %{socket: socket} do
    reuben = menu_item("Reuben")

    {:ok, order1} =
      PlateSlate.Ordering.create_order(%{
        items: [%{menu_item_id: reuben.id, quantity: 2}]
      })

    {:ok, order2} =
      PlateSlate.Ordering.create_order(%{
        items: [%{menu_item_id: reuben.id, quantity: 2}]
      })

    ref = push_doc(socket, @subscription, variables: %{"id" => order1.id})
    assert_reply ref, :ok, %{subscriptionId: _subscription_ref1}

    ref = push_doc(socket, @subscription, variables: %{"id" => order2.id})
    assert_reply ref, :ok, %{subscriptionId: subscription_ref2}

    ref = push_doc(socket, @mutation, variables: %{"id" => order2.id})
    assert_reply ref, :ok, reply

    refute reply[:errors]
    assert %{data: %{"readyOrder" => %{"state" => "ready"}}} = reply

    assert_push "subscription:data", push

    expected = %{
      result: %{data: %{"updateOrder" => %{"state" => "ready"}}},
      subscriptionId: subscription_ref2
    }

    assert expected == push
  end
end

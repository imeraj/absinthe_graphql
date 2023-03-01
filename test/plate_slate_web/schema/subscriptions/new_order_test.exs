defmodule PlateSlateWeb.Schema.Subscriptions.NewOrderTest do
  use PlateSlateWeb.SubscriptionCase

  setup do
    PlateSlate.Seeds.run()
  end

  @subscription """
  subscription {
    newOrder {
      customerNumber
    }
  }
  """

  @mutation """
  mutation($input: PlaceOrderInput!) {
    placeOrder(input: $input) {
      ... on Order {
        id
      }
    }
  }
  """

  defp menu_item(name), do: PlateSlate.Repo.get_by!(PlateSlate.Menu.Item, name: name)

  test "new orders can be subscribed to", %{socket: socket} do
    # setup a subscription
    ref = push_doc(socket, @subscription)
    assert_reply ref, :ok, %{subscriptionId: subscription_id}

    # run a mutation to trigger the subscription
    order_input = %{
      "items" => [%{"quantity" => 2, "menuItemId" => menu_item("Reuben").id}]
    }

    ref = push_doc(socket, @mutation, variables: %{"input" => order_input})
    assert_reply ref, :ok, reply
    assert %{data: %{"placeOrder" => %{"id" => _}}} = reply

    # check to see if we got subscription data

    assert_push "subscription:data", push

    assert %{
             result: %{data: %{"newOrder" => %{"customerNumber" => _}}},
             subscriptionId: ^subscription_id
           } = push
  end
end

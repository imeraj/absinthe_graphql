defmodule PlateSlateWeb.Schema.Subscriptions.NewOrderTest do
  use PlateSlateWeb.SubscriptionCase, async: true

  alias PlateSlate.Fixtures

  setup do
    PlateSlate.Seeds.run()
  end

  @login """
  mutation Login($input: LoginInput!) {
    login(input: $input) {
      ... on Session {
    	  token
      }
    }
  }
  """

  @subscription """
  subscription {
    newOrder {
      customerId
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
    # login
    user = Fixtures.create_user(%{role: "employee"})

    ref =
      push_doc(socket, @login,
        variables: %{
          input: %{
            "email" => user.email,
            "password" => "super-secret",
            "role" => String.upcase(user.role)
          }
        }
      )

    assert_reply ref, :ok, %{data: %{"login" => %{"token" => _token}}}, 5_000

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
    assert_push "subscription:data", data

    assert %{
             result: %{data: %{"newOrder" => %{"customerId" => _}}},
             subscriptionId: ^subscription_id
           } = data
  end

  test "customers can't see other customer orders", %{socket: socket} do
    customer1 = Fixtures.create_user(%{role: "customer"})

    # login as customer1
    ref =
      push_doc(socket, @login,
        variables: %{
          input: %{
            "email" => customer1.email,
            "password" => "super-secret",
            "role" => String.upcase(customer1.role)
          }
        }
      )

    assert_reply ref, :ok, %{data: %{"login" => %{"token" => _}}}, 5_000

    # subscribe to orders
    ref = push_doc(socket, @subscription)
    assert_reply ref, :ok, %{subscriptionId: _subscription_id}

    # customer1 places order
    place_order(socket)
    assert_push "subscription:data", _

    # customer2 places order
    customer2 = Fixtures.create_user(%{role: "customer"})

    # login as customer2
    ref =
      push_doc(socket, @login,
        variables: %{
          input: %{
            "email" => customer2.email,
            "password" => "super-secret",
            "role" => String.upcase(customer2.role)
          }
        }
      )

    assert_reply ref, :ok, %{data: %{"login" => %{"token" => _}}}, 5_000

    place_order(socket)
    refute_receive _
  end

  defp place_order(socket) do
    order_input = %{
      "items" => [%{"quantity" => 2, "menuItemId" => menu_item("Reuben").id}]
    }

    ref = push_doc(socket, @mutation, variables: %{"input" => order_input})
    assert_reply ref, :ok, reply
    assert %{data: %{"placeOrder" => %{"id" => _}}} = reply
  end
end

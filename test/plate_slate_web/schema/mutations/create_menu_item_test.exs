defmodule PlateSlateWeb.Schema.Mutations.CreateMenuItemTest do
  use PlateSlateWeb.ConnCase, async: true

  alias PlateSlate.Fixtures

  alias PlateSlate.{Repo, Menu}
  import Ecto.Query

  setup context do
    PlateSlate.Seeds.run()

    query =
      from c in Menu.Category,
        select: c.id,
        where:
          c.name ==
            "Sandwiches"

    category_id = Repo.one!(query)

    user = Fixtures.create_user(%{role: "employee"})
    conn = auth_user(context.conn, user)

    {:ok, category_id: category_id, conn: conn}
  end

  @query """
  mutation CreateMenuItem($menuItem: CreateMenuItemInput!) {
    createMenuItem(input: $menuItem) {
      ... on MenuItem {
        name
        description
        price
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
  test "createMenuItem creates an item", %{category_id: category_id, conn: conn} do
    menu_item = %{
      "name" => "French Dip",
      "description" => "Raost beef, caramelized onions, ...",
      "price" => 5.75,
      "category_id" => category_id
    }

    conn = post(conn, "/api", query: @query, variables: %{"menuItem" => menu_item})

    assert %{
             "data" => %{
               "createMenuItem" => %{
                 "description" => "Raost beef, caramelized onions, ...",
                 "name" => "French Dip",
                 "price" => "5.75"
               }
             }
           } = json_response(conn, 200)
  end

  test "createMenuItem with an existing name fails", %{category_id: category_id, conn: conn} do
    menu_item = %{
      "name" => "French Dip",
      "description" => "Raost beef, caramelized onions, ...",
      "price" => 5.75,
      "category_id" => category_id
    }

    conn = post(conn, "/api", query: @query, variables: %{"menuItem" => menu_item})
    conn = post(conn, "/api", query: @query, variables: %{"menuItem" => menu_item})

    assert %{
             "data" => %{"createMenuItem" => nil},
             "errors" => [
               %{
                 "key" => "name",
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => ["has already been taken"],
                 "path" => ["createMenuItem"]
               }
             ]
           } =
             json_response(conn, 200)
  end

  test "createMenuItem with unauthorized user fails", %{category_id: category_id} do
    menu_item = %{
      "name" => "French Dip",
      "description" => "Raost beef, caramelized onions, ...",
      "price" => 5.75,
      "category_id" => category_id
    }

    conn = build_conn()
    conn = post(conn, "/api", query: @query, variables: %{"menuItem" => menu_item})

    assert %{
             "data" => %{"createMenuItem" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "unauthorized",
                 "path" => ["createMenuItem"]
               }
             ]
           } == json_response(conn, 200)
  end

  defp auth_user(conn, user) do
    token = PlateSlateWeb.Authentication.sign(%{role: user.role, id: user.id})
    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end

defmodule PlateSlateWeb.Schema.Mutations.CreateMenuTest do
  use PlateSlateWeb.ConnCase, async: true

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

    {:ok, category_id: category_id, conn: context.conn}
  end

  @query """
  mutation CreateMenuItem($menuItem: CreateMenuItemInput!) {
    createMenuItem(input: $menuItem) {
      menuItem {
        name
        description
        price
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
                 "menuItem" => %{
                   "description" => "Raost beef, caramelized onions, ...",
                   "name" => "French Dip",
                   "price" => "5.75"
                 }
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
                 "message" => "could not create menu item",
                 "path" => ["createMenuItem"]
               }
             ]
           } = json_response(conn, 200)
  end
end

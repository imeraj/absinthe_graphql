defmodule PlateSlateWeb.Schema.Query.MenuItemsTest do
  use PlateSlateWeb.ConnCase, async: true

  @query """
  {
    menuItems {
      id
      name
    }
  }
  """

  test "menuItems field returns menu items" do
    conn = build_conn()
    conn = post conn, "/api", query: @query

    assert %{
             "data" => %{
               "menuItems" => [
                 %{"name" => _, "id" => _} | _
               ]
             }
           } = json_response(conn, 200)
  end
end

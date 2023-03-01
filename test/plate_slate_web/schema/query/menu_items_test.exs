defmodule PlateSlateWeb.Schema.Query.MenuItemsTest do
  use PlateSlateWeb.ConnCase, async: true

  setup _ do
    PlateSlate.Seeds.run()
  end

  @query """
  {
    menuItems {
      id
      name
    }
  }
  """
  test "menuItems field returns menu items", %{conn: conn} do
    conn = post(conn, "/api", query: @query)

    assert %{
             "data" => %{
               "menuItems" => [
                 %{"name" => _, "id" => _} | _
               ]
             }
           } = json_response(conn, 200)
  end

  @query """
  {
    menuItems(matching: "reu") {
      name
    }
  }
  """
  test "menuItems field returns menu items filtered by name", %{conn: conn} do
    response = post(conn, "/api", query: @query)

    assert %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Reuben"}
               ]
             }
           } = json_response(response, 200)
  end
end

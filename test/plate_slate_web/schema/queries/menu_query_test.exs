defmodule PlateSlateWeb.Schema.Queries.MenuQueryTest do
  use PlateSlateWeb.ConnCase, async: true

  setup _ do
    PlateSlate.Seeds.run()
  end

  @query """
  {
    menu {
      menuItems {
        id
        name
      }
    }
  }
  """
  test "menuItems field returns menu items", %{conn: conn} do
    conn = post(conn, "/api", query: @query)

    assert %{
             "data" => %{
               "menu" => %{
                 "menuItems" => [
                   %{"name" => _, "id" => _} | _
                 ]
               }
             }
           } = json_response(conn, 200)
  end

  @query """
  query($filter: MenuItemFilter) {
    menu(filter: $filter) {
      menuItems {
        name
      }
    }
  }
  """
  @variables %{filter: %{"name" => "reu"}}
  test "menuItems field returns menu items filtered by name", %{conn: conn} do
    response = post(conn, "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "menu" => %{
                 "menuItems" => [
                   %{"name" => "Reuben"}
                 ]
               }
             }
           } = json_response(response, 200)
  end
end

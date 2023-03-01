defmodule PlateSlateWeb.Graphql.Queries.MenuQueryTest do
  use PlateSlateWeb.ConnCase, async: true

  setup _ do
    PlateSlate.Seeds.run()
  end

  @query """
  {
      menuItems(first: 100) {
        edges {
          node {
            id
            name
          }
        }
      }
  }
  """
  test "menuItems field returns menu items", %{conn: conn} do
    conn = post(conn, "/api", query: @query)

    assert %{
             "data" => %{
               "menuItems" => %{"edges" => [%{"node" => %{"name" => "Bánh mì"}} | _]}
             }
           } = json_response(conn, 200)
  end

  @query """
  query($filter: MenuItemFilter) {
    menuItems(filter: $filter, first: 100) {
      edges {
        node {
          name
        }
      }
    }
  }
  """
  @variables %{filter: %{"name" => "reu"}}
  test "menuItems field returns menu items filtered by name", %{conn: conn} do
    response = post(conn, "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "menuItems" => %{"edges" => [%{"node" => %{"name" => "Reuben"}}]}
             }
           } = json_response(response, 200)
  end

  @query """
  query($order: SortOrder!) {
      menuItems(order: $order, first: 100) {
        edges {
          node {
            name
          }
        }
      }
    }
  """
  @variables %{"order" => "DESC"}
  test "menuItems field returns menu items descending by name", %{conn: conn} do
    response = post(conn, "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "menuItems" => %{"edges" => [%{"node" => %{"name" => "Water"}} | _]}
             }
           } = json_response(response, 200)
  end

  @query """
  query ($filter: MenuItemFilter)	{
    menuItems(filter: $filter, first: 100)	{
      edges {
        node {
          name
        }
  	  }
    }
  }
  """
  @variables %{filter: %{"tag" => "Vegetarian", "category" => "Sandwiches"}}
  test "menuItems field returns menuItems, filtering with a variable", %{conn: conn} do
    response = post(conn, "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "menuItems" => %{"edges" => [%{"node" => %{"name" => "Vada Pav"}}]}
             }
           } = json_response(response, 200)
  end

  @query """
  query ($filter: MenuItemFilter)	{
    menuItems(filter: $filter, first: 100)	{
      edges {
        node {
          name
          addedOn
        }
  	  }
    }
  }
  """
  @variables %{filter: %{"addedBefore" => "2017-01-20"}}
  test "menuItems filtered by custom scalar", %{conn: conn} do
    sides = PlateSlate.Repo.get_by!(PlateSlate.Menu.Category, name: "Sides")

    %PlateSlate.Menu.Item{
      name: "Garlic Fries",
      added_on: ~D[2017-01-01],
      price: 2.50,
      category: sides
    }
    |> PlateSlate.Repo.insert!()

    response = post(conn, "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "menuItems" => %{
                 "edges" => [%{"node" => %{"addedOn" => "2017-01-01", "name" => "Garlic Fries"}}]
               }
             }
           } = json_response(response, 200)
  end

  @query """
  query ($filter: MenuItemFilter)	{
    menuItems(filter: $filter)	{
      edges {
        node {
          name
          addedOn
        }
  	  }
    }
  }
  """
  @variables %{filter: %{"addedBefore" => "not-a-date"}}
  test "menuItems filtered by custom scalar with error", %{conn: conn} do
    response = post(conn, "/api", query: @query, variables: @variables)

    assert %{
             "errors" => [
               %{
                 "message" => message
               }
             ]
           } = json_response(response, 200)

    expected = """
    Argument \"filter\" has invalid value $filter.
    In field \"addedBefore\": Expected type \"Date\", found \"not-a-date\".\
    """

    assert expected == message
  end
end

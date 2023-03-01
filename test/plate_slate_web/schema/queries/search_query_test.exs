defmodule PlateSlateWeb.Graphql.Queries.SearchQueryTest do
  use PlateSlateWeb.ConnCase, async: true

  setup _ do
    PlateSlate.Seeds.run()
  end

  @query """
  query Search($term: String!) {
    search(matching: $term) {
  	  ... on MenuItem {
        name
      }
      ... on Category {
        name
      }
      __typename
    }
  }
  """
  @variables %{term: "e"}
  test "search returns a list of menu items and categories", %{conn: conn} do
    response = post(conn, "/api", query: @query, variables: @variables)

    assert %{"data" => %{"search" => results}} = json_response(response, 200)
    assert length(results) > 0
    assert Enum.find(results, &(&1["__typename"] == "Category"))
    assert Enum.find(results, &(&1["__typename"] == "MenuItem"))
  end
end

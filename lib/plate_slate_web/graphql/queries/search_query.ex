defmodule PlateSlateWeb.Graphql.Queries.SearchQuery do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.SearchResolver

   @desc "search menu items or category"
  object :search_query do

    field :search, non_null(list_of(:search_payload)) do
      arg(:matching, non_null(:string), description: "Filter for menu items")

      resolve(&SearchResolver.search/3)
    end
  end
end

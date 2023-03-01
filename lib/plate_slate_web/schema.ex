defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types(PlateSlateWeb.Graphql.Queries.MenuQuery)

  query do
    import_fields(:menu_query)
  end
end

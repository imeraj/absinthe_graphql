defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types(PlateSlateWeb.Graphql.Types.Scalars.Date)
  import_types(PlateSlateWeb.Graphql.Types.Scalars.Decimal)

  import_types(PlateSlateWeb.Graphql.Types.MenuItemType)
  import_types(PlateSlateWeb.Graphql.Types.CategoryType)

  import_types(PlateSlateWeb.Graphql.InputTypes.MenuItemFilter)

  import_types(PlateSlateWeb.Graphql.Queries.MenuQuery)
  import_types(PlateSlateWeb.Graphql.Queries.SearchQuery)

  import_types(PlateSlateWeb.Graphql.Payloads.MenuPayload)
  import_types(PlateSlateWeb.Graphql.Payloads.SearchPayload)

  query do
    import_fields(:menu_query)
    import_fields(:search_query)
  end
end

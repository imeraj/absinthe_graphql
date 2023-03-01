defmodule PlateSlateWeb.Schema do
  @moduledoc false

  use Absinthe.Schema
  alias PlateSlateWeb.Middlewares.ChangesetErrors

  import_types(PlateSlateWeb.Graphql.Types.Scalars.Date)
  import_types(PlateSlateWeb.Graphql.Types.Scalars.Decimal)

  import_types(PlateSlateWeb.Graphql.Types.Enums.SortOrderEnum)

  import_types(PlateSlateWeb.Graphql.Types.Error)
  import_types(PlateSlateWeb.Graphql.Types.MenuItemType)
  import_types(PlateSlateWeb.Graphql.Types.CategoryType)
  import_types(PlateSlateWeb.Graphql.Types.OrderType)

  import_types(PlateSlateWeb.Graphql.InputTypes.MenuItemFilter)
  import_types(PlateSlateWeb.Graphql.InputTypes.CreateMenuItemInput)
  import_types(PlateSlateWeb.Graphql.InputTypes.PlaceOrderInput)

  import_types(PlateSlateWeb.Graphql.Queries.MenuQuery)
  import_types(PlateSlateWeb.Graphql.Queries.SearchQuery)

  import_types(PlateSlateWeb.Graphql.Mutations.CreateMenuItemMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.PlaceOrderMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.ReadyOrderMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.CompleteOrderMutation)

  import_types(PlateSlateWeb.Graphql.Mutations.NewOrderSubscription)
  import_types(PlateSlateWeb.Graphql.Mutations.UpdateOrderSubscription)

  import_types(PlateSlateWeb.Graphql.Payloads.MenuPayload)
  import_types(PlateSlateWeb.Graphql.Payloads.SearchPayload)
  import_types(PlateSlateWeb.Graphql.Payloads.CreateMenuItemPayload)
  import_types(PlateSlateWeb.Graphql.Payloads.PlaceOrderPayload)
  import_types(PlateSlateWeb.Graphql.Payloads.ReadyOrderPayload)
  import_types(PlateSlateWeb.Graphql.Payloads.CompleteOrderPayload)

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  query do
    import_fields(:menu_query)
    import_fields(:search_query)
  end

  mutation do
    import_fields(:create_menu_item_mutation)
    import_fields(:place_order_mutation)
    import_fields(:ready_order_mutation)
    import_fields(:complete_order_mutation)
  end

  subscription do
    import_fields(:new_order_subscription)
    import_fields(:update_order_subscription)
  end
end

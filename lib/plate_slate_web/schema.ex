defmodule PlateSlateWeb.Schema do
  @moduledoc false

  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias PlateSlateWeb.Middlewares
  alias PlateSlateWeb.Dataloader

  # required for directives
  import_types(Absinthe.Phoenix.Types)
  @prototype_schema PlateSlateWeb.Graphql.Directives.FeatureFlagDirective

  import_types(PlateSlateWeb.Graphql.Types.Scalars.Date)
  import_types(PlateSlateWeb.Graphql.Types.Scalars.Decimal)

  import_types(PlateSlateWeb.Graphql.Types.Enums.SortOrderEnum)
  import_types(PlateSlateWeb.Graphql.Types.Enums.RoleEnum)

  import_types(PlateSlateWeb.Graphql.Types.ErrorType)
  import_types(PlateSlateWeb.Graphql.Types.UserType)
  import_types(PlateSlateWeb.Graphql.Types.MenuItemType)
  import_types(PlateSlateWeb.Graphql.Types.CategoryType)
  import_types(PlateSlateWeb.Graphql.Types.OrderType)
  import_types(PlateSlateWeb.Graphql.Types.SessionType)

  import_types(PlateSlateWeb.Graphql.Queries.MenuQuery)
  import_types(PlateSlateWeb.Graphql.Queries.SearchQuery)

  import_types(PlateSlateWeb.Graphql.Mutations.SignupMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.LoginMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.CreateMenuItemMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.PlaceOrderMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.ReadyOrderMutation)
  import_types(PlateSlateWeb.Graphql.Mutations.CompleteOrderMutation)

  import_types(PlateSlateWeb.Graphql.Subscriptions.NewOrderSubscription)
  import_types(PlateSlateWeb.Graphql.Subscriptions.UpdateOrderSubscription)

  def context(ctx), do: Map.put(ctx, :loader, Dataloader.dataloader())

  def plugins, do: [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]

  def middleware(middleware, field, object) do
    middleware
    |> apply(:errors, field, object)
    |> apply(:debug, field, object)
  end

  defp apply(middleware, :errors, _field, %{identifier: :mutation}) do
    middleware ++ [Middlewares.ChangesetErrors]
  end

  defp apply(middleware, :debug, _field, _object) do
    if System.get_env("DEBUG"),
      do: [{Middlewares.Debug, :start}] ++ middleware,
      else: middleware
  end

  defp apply(middleware, _, _, _), do: middleware

  query do
    import_fields(:menu_query)
    import_fields(:search_query)
  end

  mutation do
    import_fields(:signup_mutation)
    import_fields(:login_mutation)
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

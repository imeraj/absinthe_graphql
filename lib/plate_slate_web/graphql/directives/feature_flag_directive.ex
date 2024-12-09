defmodule PlateSlateWeb.Graphql.Directives.FeatureFlagDirective do
  @moduledoc false

  use Absinthe.Schema.Prototype

  directive :feature_flag do
    arg(:flag, non_null(:string), description: "Skipped when flag not set.")
    on([:field, :field_definition, :fragment_spread, :inline_fragment])

    expand(fn
      %{flag: flag}, node ->
        case Application.get_env(:plate_slate, String.to_existing_atom(flag), false) do
          true ->
            node

          false ->
            Absinthe.Blueprint.put_flag(node, :skip, __MODULE__)
        end
    end)
  end
end

defmodule PlateSlateWeb.Graphql.Types.Enums.SortOrderEnum do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Sorting order"
  enum :sort_order do
    value(:asc, description: "Ascending")
    value(:desc, description: "Descending")
  end
end

defmodule PlateSlateWeb.Graphql.Types.OrderType do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "An order"
  object :order do
    field :id, non_null(:id)
    field :customer_number, non_null(:string)
    field :items, non_null(list_of(non_null(:order_item)))
    field :state, non_null(:string)
  end

  object :order_item do
    field :name, non_null(:string)
    field :price, non_null(:decimal)
    field :quantity, non_null(:integer)
  end
end

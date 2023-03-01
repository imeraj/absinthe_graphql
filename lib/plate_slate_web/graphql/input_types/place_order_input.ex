defmodule PlateSlateWeb.Graphql.InputTypes.PlaceOrderInput do
  @moduledoc false

  use Absinthe.Schema.Notation

  input_object :order_item_input do
    field :menu_item_id, non_null(:id)
    field :quantity, non_null(:integer)
  end

  input_object :place_order_input do
    field :items, non_null(list_of(non_null(:order_item_input)))
  end
end

defmodule PlateSlateWeb.Graphql.InputTypes.CreateMenuItemInput do
  @moduledoc false

  use Absinthe.Schema.Notation

  input_object :create_menu_item_input do
    field :name, non_null(:string)
    field :description, :string
    field :price, non_null(:float)
    field :category_id, non_null(:id)
  end
end

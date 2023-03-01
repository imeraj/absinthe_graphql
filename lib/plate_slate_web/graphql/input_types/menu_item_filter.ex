defmodule PlateSlateWeb.Graphql.InputTypes.MenuItemFilter do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Filtering options for the menu items list"
  input_object :menu_item_filter do
    @desc "Matching a name"
    field :name, :string
  end
end

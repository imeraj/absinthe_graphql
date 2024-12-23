defmodule PlateSlateWeb.Graphql.InputTypes.MenuItemFilter do
  @moduledoc false

  use Absinthe.Schema.Notation


  @desc "Filtering options for the menu items list"
  input_object :menu_item_filter do
    @desc "Matching a name"
    field :name, :string

    @desc "Matching a category name"
    field :category, :string

    @desc "Matching a tag"
    field :tag, :string

    @desc "Priced above a value"
    field :price_above, :float

    @desc "Priced below a value"
    field :price_below, :float

    @desc "Added to the menu before this date"
    field :added_before, :date

    @desc "Added to the menu after this date"
    field :added_after, :date
  end
end

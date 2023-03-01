defmodule PlateSlateWeb.Graphql.Types.CategoryType do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "A category"
  object :category do
    field :id, non_null(:id), description: "Category ID"
    field :name, non_null(:string), description: "Category name"
    field :description, :string, description: "Category description"

    field :items, list_of(:menu_item), description: "Menu items for category" do
      # this will result in N+1 query problem
      resolve(&items_for_category/3)
    end
  end

  defp items_for_category(category, _, _) do
    query = Ecto.assoc(category, :items)
    {:ok, PlateSlate.Repo.all(query)}
  end
end

defmodule PlateSlateWeb.Graphql.Types.CategoryType do
  @moduledoc false

  use Absinthe.Schema.Notation

  #  import Absinthe.Resolution.Helpers, only: [on_load: 2]
  import Absinthe.Resolution.Helpers

  alias PlateSlate.Menu

  @desc "A category"
  object :category do
    field :id, non_null(:id), description: "Category ID"
    field :name, non_null(:string), description: "Category name"
    field :description, :string, description: "Category description"

    field :items, list_of(:menu_item), description: "Menu items for category" do
      arg(:filter, :menu_item_filter)
      arg(:order, :sort_order, default_value: :asc)

      # can pass additional arguments with {:category, args)
      # see - https://hexdocs.pm/absinthe/Absinthe.Resolution.Helpers.html#dataloader/3-options
      resolve(dataloader(Menu, :items))
    end
  end

  @doc """
  Load items manually. Line 20. uses a helper to automate this
  """

  #  defp items_for_category(category, args, %{context: %{loader: loader}}) do
  #    loader
  #    |> Dataloader.load(Menu, {:items, args}, category)
  #    |> on_load(fn loader ->
  #      items = Dataloader.get(loader, Menu, {:items, args}, category)
  #      {:ok, items}
  #    end)
  #  end
end

defmodule PlateSlateWeb.Graphql.Types.MenuItemType do
  @moduledoc false

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  import Ecto.Query, warn: false
  # import Absinthe.Resolution.Helpers, only: [async: 1, batch: 3]
  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  alias PlateSlate.Menu

  connection(node_type: :menu_item)

  @desc "A menu item"
  object :menu_item do
    field :id, non_null(:id), description: "Menu item ID"
    field :name, non_null(:string), description: "Menu item name"
    field :description, :string, description: "Menu item description"
    field :price, non_null(:decimal), description: "Menu item price"

    field :added_on, :date, description: "Menu item added on date"

    field :allergy_info, non_null(list_of(non_null(:allergy_info))),
      description: "Allergy information"

    #    @doc """
    #    Async version
    #    """

    #    field :category, :category do
    #      resolve(fn menu_item, _, _ ->
    #        async(fn ->
    #          query = Ecto.assoc(menu_item, :category)
    #          {:ok, PlateSlate.Repo.one(query)}
    #        end)
    #      end)
    #    end

    #    @doc """
    #    Batch version
    #    """

    #    field :category, :category do
    #      resolve(fn menu_item, _, _ ->
    #        batch({PlateSlate.Menu, :categories_by_id}, menu_item.category_id, fn
    #          categories ->
    #            {:ok, Map.get(categories, menu_item.category_id)}
    #        end)
    #      end)
    #    end

    @doc """
    Dataloader version
    """

    field :category, :category do
      directive(:feature_flag, flag: "secret_feature_flag")

      resolve(fn menu_item, _, %{context: %{loader: loader}} ->
        loader
        |> Dataloader.load(Menu, :category, menu_item)
        |> on_load(fn loader ->
          # can pass additional arguments with {:category, args)
          # see - https://hexdocs.pm/absinthe/Absinthe.Resolution.Helpers.html#dataloader/3-options
          category = Dataloader.get(loader, Menu, :category, menu_item)
          {:ok, category}
        end)
      end)
    end
  end
end

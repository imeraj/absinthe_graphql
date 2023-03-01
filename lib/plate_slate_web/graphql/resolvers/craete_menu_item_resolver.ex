defmodule PlateSlateWeb.Graphql.Resolvers.CreateMenuItemResolver do
  @moduledoc false

  alias PlateSlate.Menu

  def create_menu_item(_, %{input: params}, _) do
    with {:ok, menu_item} <- Menu.create_item(params) do
      # this is because menu_item is a basic type. We don't need to return a map
      {:ok, menu_item}
    end
  end
end

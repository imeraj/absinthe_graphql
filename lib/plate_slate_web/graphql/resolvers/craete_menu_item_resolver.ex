defmodule PlateSlateWeb.Graphql.Resolvers.CreateMenuItemResolver do
  @moduledoc false

  alias PlateSlate.Menu
  alias PlateSlateWeb.Utils

  def create_menu_item(_, %{input: params}, _) do
    case Menu.create_item(params) do
      {:error, changeset} ->
        {:ok, %{errors: Utils.transform_errors(changeset)}}

      {:ok, menu_item} ->
        # this is because menu_item is a basic type. We don't need to return a map
        {:ok, menu_item}
    end
  end
end

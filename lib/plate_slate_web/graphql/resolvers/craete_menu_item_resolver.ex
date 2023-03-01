defmodule PlateSlateWeb.Graphql.Resolvers.CreateMenuItemResolver do
  @moduledoc false
  alias PlateSlate.Menu

  def create_menu_item(_, %{input: params}, _) do
    case Menu.create_item(params) do
      {:error, _} ->
        {:error, "could not create menu item"}

      {:ok, _} = success ->
        success
    end
  end
end

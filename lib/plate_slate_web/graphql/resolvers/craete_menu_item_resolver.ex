defmodule PlateSlateWeb.Graphql.Resolvers.CreateMenuItemResolver do
  @moduledoc false
  alias PlateSlate.Menu

  def create_menu_item(_, %{input: params}, _) do
    case Menu.create_item(params) do
      {:errror, _} ->
        {:error, "could not create menu items"}

      {:ok, _} = success ->
        success
    end
  end
end

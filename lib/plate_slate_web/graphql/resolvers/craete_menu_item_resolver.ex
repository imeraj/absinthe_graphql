defmodule PlateSlateWeb.Graphql.Resolvers.CreateMenuItemResolver do
  @moduledoc false

  alias PlateSlate.Menu

  def create_menu_item(_, %{input: params}, %{context: context}) do
    case context do
      %{current_user: %{role: "employee"}} ->
        with {:ok, menu_item} <- Menu.create_item(params) do
          # this is because menu_item is a basic type. We don't need to return a map
          {:ok, menu_item}
        end

      _ ->
        {:error, "unauthorized"}
    end
  end
end

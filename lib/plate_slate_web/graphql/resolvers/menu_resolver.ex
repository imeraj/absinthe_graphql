defmodule PlateSlateWeb.Graphql.Resolvers.MenuResolver do
  @moduledoc false
  alias PlateSlate.Menu

  def menu_items(_, args, _) do
    {:ok, Menu.menu_items(args)}
  end
end

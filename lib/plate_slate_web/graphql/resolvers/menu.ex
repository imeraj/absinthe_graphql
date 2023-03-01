defmodule Graphql.Resolvers.Menu do
  @moduledoc "Resolvers for Menu"
  alias PlateSlate.Menu

  def menu_items(_, args, _) do
    {:ok, Menu.menu_items(args)}
  end
end

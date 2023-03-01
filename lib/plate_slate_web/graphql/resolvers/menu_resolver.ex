defmodule PlateSlateWeb.Graphql.Resolvers.MenuResolver do
  @moduledoc false
  alias PlateSlate.Menu

  def menu_items(_, args, _) do
    Absinthe.Relay.Connection.from_query(
      Menu.items_query(args),
      &PlateSlate.Repo.all/1,
      args
    )
  end
end

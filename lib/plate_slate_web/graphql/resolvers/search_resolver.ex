defmodule PlateSlateWeb.Graphql.Resolvers.SearchResolver do
  @moduledoc false
  alias PlateSlate.Menu

  def search(_, %{matching: term}, _) do
    {:ok, Menu.search(term)}
  end
end

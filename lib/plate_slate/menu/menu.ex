defmodule PlateSlate.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false

  alias PlateSlate.Repo
  alias PlateSlate.Menu.Item

  def menu_items(%{matching: name}) when is_binary(name) do
    query = from t in Item, where: ilike(t.name, ^"%#{name}%")
    Repo.all(query)
  end

  def menu_items(_) do
    Repo.all(Item)
  end
end

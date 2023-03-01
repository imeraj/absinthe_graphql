defmodule PlateSlate.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false

  alias PlateSlate.Repo
  alias PlateSlate.Menu.Item

  def list_items(args) do
    args
    |> Enum.reduce(Item, fn
      {:order, order}, query ->
        from q in query, order_by: {^order, :name}

      {:filter, filter}, query ->
        filter_with(query, filter)
    end)
    |> Repo.all()
  end

  def filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from q in query, where: ilike(q.name, ^"%#{name}%")

      {:price_above, price}, query ->
        from q in query, where: q.price >= ^price

      {:price_below, price}, query ->
        from q in query, where: q.price < ^price

      {:category, category_name}, query ->
        from q in query,
          join: c in assoc(q, :category),
          where: ilike(c.name, ^"%#{category_name}%")

      {:tag, tag_name}, query ->
        from q in query,
          join: t in assoc(q, :tags),
          where: ilike(t.name, ^"%#{tag_name}%")
    end)
  end
end

defmodule PlateSlate.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false

  alias PlateSlate.Repo
  alias PlateSlate.Menu.Item
  alias PlateSlate.Menu.Category

  @search [Item, Category]

  def get_item(id), do: Repo.get(Item, id)

  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

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

  def categories_by_id(_, ids) do
    query = from c in Category, where: c.id in ^Enum.uniq(ids)

    query
    |> Repo.all()
    |> Map.new(fn category ->
      {category.id, category}
    end)
  end

  def search(term), do: Enum.flat_map(@search, &do_search(&1, "%#{term}%"))

  defp do_search(model, pattern) when model in @search do
    query =
      from q in model,
        where: ilike(q.name, ^pattern) or ilike(q.description, ^pattern)

    Repo.all(query)
  end

  defp filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from q in query, where: ilike(q.name, ^"%#{name}%")

      {:price_above, price}, query ->
        from q in query, where: q.price >= ^price

      {:price_below, price}, query ->
        from q in query, where: q.price <= ^price

      {:added_after, date}, query ->
        from q in query, where: q.added_on >= ^date

      {:added_before, date}, query ->
        from q in query, where: q.added_on <= ^date

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

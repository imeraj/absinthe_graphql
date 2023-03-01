defmodule PlateSlate.Ordering.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlateSlate.Ordering.{Order, Item}
  alias PlateSlate.Accounts.User

  schema "orders" do
    field :ordered_at, :naive_datetime, read_after_writes: true
    field :state, :string

    embeds_many(:items, Item, on_replace: :delete)
    belongs_to :customer, User

    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:customer_id, :ordered_at, :state])
    |> cast_embed(:items)
  end
end

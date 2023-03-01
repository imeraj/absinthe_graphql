defmodule PlateSlate.Ordering.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlateSlate.Ordering.Order
  alias PlateSlate.Accounts.User

  schema "orders" do
    field :customer_number, :integer, read_after_writes: true
    field :ordered_at, :naive_datetime, read_after_writes: true
    field :state, :string

    embeds_many(:items, PlateSlate.Ordering.Item, on_replace: :delete)
    belongs_to :customer, User

    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:customer_number, :ordered_at, :state])
    |> cast_embed(:items)
  end
end

defmodule PlateSlate.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias PlateSlate.Ordering.Order

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, Comeonin.Ecto.Password
    field :role, :string

    has_many :orders, Order, foreign_key: :customer_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :role])
    |> validate_required([:name, :email, :password, :role])
    |> unique_constraint([:email, :role])
  end
end

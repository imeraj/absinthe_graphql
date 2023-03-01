defmodule PlateSlateWeb.Graphql.Types.Enums.RoleEnum do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Roles"
  enum :role do
    value(:customer, as: "customer")
    value(:employee, as: "employee")
  end
end

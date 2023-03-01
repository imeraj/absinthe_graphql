defmodule PlateSlateWeb.Graphql.Types.Enums.RoleEnum do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Roles"
  enum :role do
    value(:customer, as: "customer", description: "Customer role")
    value(:employee, as: "employee", description: "Employee role")
  end
end

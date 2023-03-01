defmodule PlateSlateWeb.Graphql.InputTypes.LoginInput do
  @moduledoc false

  use Absinthe.Schema.Notation

  input_object :login_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :role, non_null(:role)
  end
end

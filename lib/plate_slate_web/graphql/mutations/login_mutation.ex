defmodule PlateSlateWeb.Graphql.Mutations.LoginMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Graphql.Resolvers.LoginResolver

  object :login_mutation do
    @desc "Login"
    field :login, :session_payload do
      arg(:input, non_null(:login_input))
      resolve(&LoginResolver.login/3)
    end
  end
end

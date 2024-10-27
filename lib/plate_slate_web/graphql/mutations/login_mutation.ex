defmodule PlateSlateWeb.Graphql.Mutations.LoginMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  import_types(PlateSlateWeb.Graphql.Payloads.LoginPayload)
  import_types(PlateSlateWeb.Graphql.InputTypes.LoginInput)

  alias PlateSlateWeb.Graphql.Resolvers.LoginResolver

  object :login_mutation do
    @desc "Login"
    field :login, :session_payload do
      arg(:input, non_null(:login_input))
      resolve(&LoginResolver.login/3)

      middleware(fn res, _ ->
        with %{value: %{user: user}} <- res do
          %{res | context: Map.put(res.context, :current_user, user)}
        end
      end)
    end
  end
end

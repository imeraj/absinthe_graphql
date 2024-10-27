defmodule PlateSlateWeb.Graphql.Mutations.SignupMutation do
  @moduledoc false

  use Absinthe.Schema.Notation
  import_types(PlateSlateWeb.Graphql.Payloads.SignupPayload)
  import_types(PlateSlateWeb.Graphql.InputTypes.SignupInput)

  alias PlateSlateWeb.Graphql.Resolvers.SignupResolver

  object :signup_mutation do
    @desc "Signup"
    field :signup, :signup_payload do
      arg(:input, non_null(:signup_input))
      resolve(&SignupResolver.signup/3)
    end
  end
end

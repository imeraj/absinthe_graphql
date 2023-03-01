defmodule PlateSlateWeb.Graphql.Payloads.SignupPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Signup payload"
  union :signup_payload do
    types([:customer, :employee, :errors])

    resolve_type(fn
      %PlateSlate.Accounts.User{} = user, _ ->
        case user.role do
          "customer" -> :customer
          "employee" -> :employee
        end

      %{errors: _}, _ ->
        :errors

      _, _ ->
        nil
    end)
  end
end

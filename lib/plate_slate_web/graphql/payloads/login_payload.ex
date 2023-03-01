defmodule PlateSlateWeb.Graphql.Payloads.LoginPayload do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Login payload"
  union :session_payload do
    types([:session, :errors])

    resolve_type(fn
      %{token: _token, user: _user} = _session, _ ->
        :session

      %{errors: _}, _ ->
        :errors

      _, _ ->
        nil
    end)
  end
end

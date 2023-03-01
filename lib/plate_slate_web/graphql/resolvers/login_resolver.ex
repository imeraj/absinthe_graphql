defmodule PlateSlateWeb.Graphql.Resolvers.LoginResolver do
  @moduledoc false

  alias PlateSlate.Accounts

  def login(_, %{input: %{email: email, password: password, role: role}}, _) do
    with {:ok, user} <- Accounts.authenticate(role, email, password) do
      token =
        PlateSlateWeb.Authentication.sign(%{
          role: role,
          id: user.id
        })

      {:ok, %{token: token, user: user}}
    end
  end
end

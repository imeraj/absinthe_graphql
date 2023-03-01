defmodule PlateSlateWeb.Graphql.Resolvers.SignupResolver do
  @moduledoc false

  alias PlateSlate.Accounts

  def signup(_, %{input: params}, _) do
    with {:ok, user} <- Accounts.create_user(params) do
      {:ok, user}
    end
  end
end

defmodule PlateSlateWeb.Graphql.Middlewares.Authorize do
  @moduledoc false

  @behaviour Absinthe.Middleware

  @impl Absinthe.Middleware
  def call(resolution, role) do
    with %{current_user: current_user} <- resolution.context,
         true <- correct_role?(current_user, role) do
      resolution
    else
      _ -> Absinthe.Resolution.put_result(resolution, {:error, "unauthorized"})
    end
  end

  defp correct_role?(%{role: role}, role), do: true
  defp correct_role?(%{}, :any), do: true
  defp correct_role?(_, _), do: false
end

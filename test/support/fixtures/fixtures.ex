defmodule PlateSlate.Fixtures do
  @moduledoc false

  def create_user(attrs \\ %{}) do
    int = :erlang.unique_integer([:positive, :monotonic])

    {:ok, user} =
      Map.merge(
        %{
          name: "Person #{int}",
          email: "fake-#{int}@example.com",
          password: "super-secret",
          role: "customer"
        },
        attrs
      )
      |> PlateSlate.Accounts.create_user()

    user
  end
end

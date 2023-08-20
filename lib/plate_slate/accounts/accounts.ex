defmodule PlateSlate.Accounts do
  @moduledoc false

  import Ecto.Query, warn: false

  alias PlateSlate.Repo
  alias Comeonin.Ecto.Password
  alias PlateSlate.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate(role, email, password) do
    with {:user, user} when not is_nil(user) <-
           {:user, Repo.get_by(User, role: to_string(role), email: email)},
         %{password: digest} <- user,
         true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      {:user, _} ->
        {:error, "incorrect role"}

      _ ->
        {:error, "incorrect email or password"}
    end
  end

  def lookup(role, id), do: Repo.get_by(User, role: to_string(role), id: id)
end

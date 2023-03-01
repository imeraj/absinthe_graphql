defmodule PlateSlateWeb.Authentication do
  @moduledoc false

  @user_salt "user salt"

  def sign(data) do
    Phoenix.Token.sign(PlateSlateWeb.Endpoint, @user_salt, data)
  end

  def verify(token) do
    with {:ok, data} <-
           Phoenix.Token.verify(PlateSlateWeb.Endpoint, @user_salt, token,
             max_age: 365 * 24 * 3600
           ) do
      {:ok, get_user(data)}
    end
  end

  defp get_user(%{id: id, role: role}), do: PlateSlate.Accounts.lookup(role, id)
end

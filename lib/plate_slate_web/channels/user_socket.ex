defmodule PlateSlateWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: PlateSlateWeb.Schema

  @doc """
  For graphql subscriptions to work must implement below callbacks
  """

  @impl true
  def connect(params, socket, _connect_info) do
    socket =
      Absinthe.Phoenix.Socket.put_options(socket,
        context: build_context(params)
      )

    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil

  defp build_context(params) do
    with "Bearer " <> token <- params["Authorization"],
         {:ok, user} <- PlateSlateWeb.Authentication.verify(token) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end

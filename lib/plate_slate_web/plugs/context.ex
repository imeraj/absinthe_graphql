defmodule PlateSlateWeb.Plugs.Context do
  @moduledoc false

  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)

    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- PlateSlateWeb.Authentication.verify(token) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end

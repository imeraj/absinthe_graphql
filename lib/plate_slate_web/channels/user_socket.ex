defmodule PlateSlateWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: PlateSlateWeb.Schema
end

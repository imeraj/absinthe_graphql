defmodule PlateSlateWeb.Schema.Types.SessionType do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :session do
    field :token, non_null(:string)
    field :user, non_null(:user)
  end
end

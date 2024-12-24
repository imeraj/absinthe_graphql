defmodule PlateSlateWeb.Graphql.Types.ErrorType do
  use Absinthe.Schema.Notation

  @desc "mutation errors"
  object :errors do
    field :errors, non_null(list_of(:error))
  end

  @desc "mutation error type"
  object :error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end
end

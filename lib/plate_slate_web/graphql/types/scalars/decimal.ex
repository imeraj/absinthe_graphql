### Commented out in favour of Absinthe.Type.Custom

# defmodule PlateSlateWeb.Graphql.Types.Scalars.Decimal do
#  @moduledoc false
#
#  use Absinthe.Schema.Notation
#
#  scalar :decimal do
#    parse(fn
#      %{value: value} ->
#        {decimal, _} = Decimal.parse(value)
#        decimal
#
#      _ ->
#        :error
#    end)
#
#    serialize(&to_string/1)
#  end
# end

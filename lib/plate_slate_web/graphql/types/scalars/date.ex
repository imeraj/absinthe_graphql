### Commented out in favour of Absinthe.Type.Custom

# defmodule PlateSlateWeb.Graphql.Types.Scalars.Date do
#  @moduledoc false
#
#  use Absinthe.Schema.Notation
#
#  scalar :date do
#    parse(fn %Absinthe.Blueprint.Input.String{value: value} ->
#      case Date.from_iso8601(value) do
#        {:ok, date} -> {:ok, date}
#        _ -> :error
#      end
#    end)
#
#    serialize(&Date.to_iso8601/1)
#  end
# end

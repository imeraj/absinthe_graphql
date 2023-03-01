defmodule PlateSlateWeb.Graphql.Types.Scalars.Date do
  @moduledoc false

  use Absinthe.Schema.Notation

  scalar :date do
    parse(fn %Absinthe.Blueprint.Input.String{value: value} ->
      case Date.from_iso8601(value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date ->
      Date.to_iso8601(date)
    end)
  end
end

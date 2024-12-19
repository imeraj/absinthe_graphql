defmodule PlateSlateWeb.Phases.LogComplexity do
  @moduledoc """
  This phase is used to log complexity of a document.
  Source: https://maartenvanvliet.nl/2018/09/07/writing-an-absinthe-phase/
  """

  use Absinthe.Phase
  require Logger

  def run(input, _options \\ []) do
    operation = Absinthe.Blueprint.current_operation(input)
    {_operation, max} = Absinthe.Blueprint.prewalk(operation, 0, &handle_node(&1, &2))

    Logger.info("Query complexity: #{inspect(max)}")

    {:ok, input}
  end

  defp handle_node(%{complexity: complexity} = node, max) do
    if complexity > max, do: {node, complexity}, else: {node, max}
  end

  defp handle_node(node, max) do
    {node, max}
  end
end

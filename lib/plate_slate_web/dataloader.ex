defmodule PlateSlateWeb.Dataloader do
  @moduledoc false

  alias PlateSlate.Menu

  def dataloader, do: Dataloader.new() |> Dataloader.add_source(Menu, Menu.data())
end

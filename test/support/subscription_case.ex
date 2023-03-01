defmodule PlateSlateWeb.SubscriptionCase do
  @moduledoc """
  This module defines the test case to be used by subscription tests
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use PlateSlateWeb.ChannelCase

      use Absinthe.Phoenix.SubscriptionTest,
        schema: PlateSlateWeb.Schema

      setup do
        {:ok, socket} = Phoenix.ChannelTest.connect(PlateSlateWeb.UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, %{socket: socket}}
      end
    end
  end
end

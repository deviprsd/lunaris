defmodule Lunaris.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lunaris.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    attrs
    |> Enum.into(%{
      currency: "some currency",
      paid: "120.5",
      point_percentage: "120.5"
    })
    |> Lunaris.Orders.create_order!()
  end
end

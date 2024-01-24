defmodule Lunaris.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lunaris.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{phone: "1234567890"}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        balance: "120.5",
        email: "example@lunaris.jp"
      })
      |> Lunaris.Customers.create_customer()

    customer
  end
end

defmodule Lunaris.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lunaris.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        balance: "120.5",
        email: "some email",
        phone: "some phone"
      })
      |> Lunaris.Customers.create_customer()

    customer
  end
end

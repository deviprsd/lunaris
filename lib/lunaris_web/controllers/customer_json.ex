defmodule LunarisWeb.CustomerJSON do
  alias Lunaris.Customers.Customer

  @doc """
  Renders a list of customers.
  """
  def index(%{customers: customers}) do
    %{data: for(customer <- customers, do: data(customer))}
  end

  @doc """
  Renders a single customer.
  """
  def show(%{customer: customer}) do
    %{data: data(customer)}
  end

  def data(%Customer{} = customer) do
    %{
      id: customer.id,
      email: customer.email,
      phone: customer.phone,
      balance: customer.balance
    }
  end
end

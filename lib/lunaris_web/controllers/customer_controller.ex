defmodule LunarisWeb.CustomerController do
  use LunarisWeb, :controller

  alias Lunaris.Customers
  alias Lunaris.Customers.Customer

  action_fallback LunarisWeb.FallbackController

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Customers.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customers/#{customer}")
      |> render(:show, customer: customer)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id)
    render(conn, :show, customer: customer)
  end

  def search(conn, search_params) do
    customer = Customers.search_customer!(search_params)
    render(conn, :show, customer: customer)
  end
end

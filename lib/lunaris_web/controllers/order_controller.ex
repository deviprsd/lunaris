defmodule LunarisWeb.OrderController do
  use LunarisWeb, :controller

  alias Lunaris.Repo
  alias Lunaris.Customers
  alias Lunaris.Orders.NewOrder
  alias Lunaris.Orders

  action_fallback LunarisWeb.FallbackController

  def new(conn, new_order_request) do
    changeset =
      %NewOrder{}
      |> NewOrder.changeset(new_order_request)

    if changeset.valid? do
      new_order = Ecto.Changeset.apply_changes(changeset)
      customer_search = NewOrder.to_customer_search(new_order)

      customer = Customers.search_customer!(customer_search)
      {order, points_awarded} = NewOrder.to_order_balance(new_order, customer.id)

      with {:ok, order_inserted} <-
             Repo.transaction(fn ->
               Customers.update_balance(customer.id, points_awarded)
               Orders.create_order!(order)
             end) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/orders/#{order_inserted}")
        |> render(:show, order: order_inserted)
      end
    else
      {:error, changeset}
    end
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(id)
    render(conn, :show, order: order)
  end
end

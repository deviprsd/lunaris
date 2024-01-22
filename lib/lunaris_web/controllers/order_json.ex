defmodule LunarisWeb.OrderJSON do
  alias Lunaris.Orders.Order

  @doc """
  Renders a list of orders.
  """
  def index(%{orders: orders}) do
    %{data: for(order <- orders, do: data(order))}
  end

  @doc """
  Renders a single order.
  """
  def show(%{order: order}) do
    %{data: data(order)}
  end

  defp data(%Order{} = order) do
    %{
      id: order.id,
      paid: order.paid,
      currency: order.currency,
      point_percentage: order.point_percentage
    }
  end
end

defmodule Lunaris.OrdersTest do
  use Lunaris.DataCase

  alias Lunaris.Orders

  describe "orders" do
    alias Lunaris.Orders.Order

    import Lunaris.OrdersFixtures
    import Lunaris.CustomersFixtures

    @invalid_attrs %{currency: nil, paid: nil, point_percentage: nil}

    test "get_order!/1 returns the order with given id" do
      customer = customer_fixture()
      order = order_fixture(%{customer_id: customer.id})
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      customer = customer_fixture()

      valid_attrs = %{
        currency: "jpy",
        paid: "10000",
        point_percentage: "0.01",
        customer_id: customer.id
      }

      assert order = Orders.create_order!(valid_attrs)
      assert order.currency == "jpy"
      assert order.paid == Decimal.new("10000")
      assert order.point_percentage == Decimal.new("0.01")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert_raise Ecto.InvalidChangesetError, fn ->
        Orders.create_order!(@invalid_attrs)
      end
    end

    test "change_order/1 returns a order changeset" do
      customer = customer_fixture()
      order = order_fixture(%{customer_id: customer.id})
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end

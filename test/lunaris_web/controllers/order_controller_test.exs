defmodule LunarisWeb.OrderControllerTest do
  use LunarisWeb.ConnCase

  import Lunaris.OrdersFixtures

  alias Lunaris.Orders.Order

  @create_attrs %{
    order: %{
      paid: 10000,
      currency: "jpy",
      point_percentage: 0.05
    },
    customer: %{
      email: "example@lunaris.jp",
      phone: "1234567890"
    }
  }
  @invalid_attrs %{currency: nil, paid: nil, point_percentage: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/customers", customer: @create_attrs.customer)
      %{"id" => customer_id} = json_response(conn, 201)["data"]

      conn = post(conn, ~p"/orders/new", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/orders/#{id}")

      assert %{
               "id" => ^id,
               "currency" => "jpy",
               "paid" => "10000",
               "point_percentage" => "0.05",
               "customer" => %{
                 "id" => ^customer_id,
                 "balance" => "500",
                 "email" => "example@lunaris.jp",
                 "phone" => "1234567890"
               }
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/orders/new", order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_order(_) do
    order = order_fixture()
    %{order: order}
  end
end

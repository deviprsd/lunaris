defmodule LunarisWeb.CustomerControllerTest do
  use LunarisWeb.ConnCase

  import Lunaris.CustomersFixtures

  alias Lunaris.Customers.Customer

  @create_attrs %{
    email: "example@lunaris.jp",
    phone: "1234567890"
  }
  @invalid_attrs %{balance: nil, email: nil, phone: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create customer" do
    test "renders customer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/customers", customer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/customers/#{id}")

      assert %{
               "id" => ^id,
               "balance" => "0",
               "email" => "example@lunaris.jp",
               "phone" => "1234567890"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/customers", customer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end
end

defmodule Lunaris.CustomersTest do
  use Lunaris.DataCase

  alias Lunaris.Customers

  describe "customers" do
    alias Lunaris.Customers.Customer

    import Lunaris.CustomersFixtures

    @invalid_attrs %{balance: nil, email: nil, phone: nil}

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{balance: "120.5", email: "example1@lunaris.jp", phone: "1234567891"}

      assert {:ok, %Customer{} = customer} = Customers.create_customer(valid_attrs)
      assert customer.balance == Decimal.new("120.5")
      assert customer.email == "example1@lunaris.jp"
      assert customer.phone == "1234567891"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_balance/2 with valid balances" do
      customer = customer_fixture()

      assert {ops, nil} =
               Customers.update_balance(customer.id, 200)

      up_customer = Customers.get_customer!(customer.id)
      assert ops == 1
      assert up_customer.balance == Decimal.new("320.5")
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end

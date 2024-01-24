defmodule Lunaris.Orders.NewOrderRequest do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :id, :string
    field :paid, :integer
    field :currency, :string, default: "jpy"
    field :point_percentage, :decimal, default: Decimal.new("0.01")
  end

  def changeset(%Lunaris.Orders.NewOrderRequest{} = order, attrs \\ %{}) do
    order
    |> cast(attrs, [:id, :paid, :currency, :point_percentage])
    |> validate_required([:id, :paid])
  end
end

defmodule Lunaris.Orders.NewOrder do
  alias Lunaris.Customers.CustomerRequest
  alias Lunaris.Orders.NewOrderRequest
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one :order, NewOrderRequest
    embeds_one :customer, CustomerRequest
  end

  def changeset(%Lunaris.Orders.NewOrder{} = new_order, attrs \\ %{}) do
    new_order
    |> cast(attrs, [])
    |> cast_embed(:order, required: true, with: &NewOrderRequest.changeset/2)
    |> cast_embed(:customer, required: true, with: &CustomerRequest.changeset/2)
  end

  def to_customer_search(%Lunaris.Orders.NewOrder{} = new_order) do
    %{
      email: new_order.customer.email,
      phone: new_order.customer.phone
    }
  end

  def to_order_balance(%Lunaris.Orders.NewOrder{} = new_order, customer_id) do
    {
      %{
        id: new_order.order.id,
        paid: new_order.order.paid,
        currency: new_order.order.currency,
        point_percentage: new_order.order.point_percentage,
        customer_id: customer_id
      },
      Decimal.mult(Decimal.new(new_order.order.paid), new_order.order.point_percentage)
    }
  end
end

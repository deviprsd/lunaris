defmodule Lunaris.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :currency, :string, default: "jpy"
    field :paid, :decimal
    field :point_percentage, :decimal, default: Decimal.new("0.01")
    belongs_to :customer, Lunaris.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Lunaris.Orders.Order{} = order, attrs) do
    order
    |> cast(attrs, [:id, :paid, :currency, :point_percentage, :customer_id])
    |> validate_required([:paid, :currency, :customer_id])
    |> validate_number(:point_percentage, greater_than: 0)
    |> cast_assoc(:customer)
  end
end

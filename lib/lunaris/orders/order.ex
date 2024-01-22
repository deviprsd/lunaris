defmodule Lunaris.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :currency, :string
    field :paid, :decimal
    field :point_percentage, :decimal, default: 0.01
    belongs_to :customer, Lunaris.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:paid, :currency, :point_percentage])
    |> validate_required([:paid, :currency])
  end
end

defmodule Lunaris.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :balance, :decimal, default: 0.0
    field :email, :string
    field :phone, :string
    has_many :orders, Lunaris.Orders.Order

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :phone, :balance])
    |> validate_required([:email, :phone])
  end
end

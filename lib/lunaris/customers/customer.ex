defmodule Lunaris.Customers.Customer do
  alias Lunaris.Validations
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :balance, :decimal, default: 0.0
    field :email, :string, default: ""
    field :phone, :string, default: ""
    has_many :orders, Lunaris.Orders.Order

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Lunaris.Customers.Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:email, :phone, :balance])
    |> Validations.validate_required_inclusion([:email, :phone])
    |> unique_constraint([:email, :phone], name: :email_phone_identity)
  end
end

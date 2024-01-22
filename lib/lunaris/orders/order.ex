defmodule Lunaris.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :currency, :string
    field :paid, :decimal
    field :point_percentage, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:paid, :currency, :point_percentage])
    |> validate_required([:paid, :currency, :point_percentage])
  end
end

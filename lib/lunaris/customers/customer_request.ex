defmodule Lunaris.Customers.CustomerRequest do
  alias Lunaris.Validations
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :email, :string
    field :phone, :string
  end

  def changeset(%Lunaris.Customers.CustomerRequest{} = customer, attrs \\ %{}) do
    customer
    |> cast(attrs, [:email, :phone])
    |> Validations.validate_required_inclusion([:email, :phone])
  end
end

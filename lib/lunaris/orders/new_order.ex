defmodule Lunaris.Orders.NewOrder do
  use Ecto.Schema

  @primary_key false
  embedded_schema do
    field :id, :string
    field :paid, :integer
    field :currency, :string
  end
end

defmodule Lunaris.Orders.Customer do
  use Ecto.Schema

  @primary_key false
  embedded_schema do
    field :email, :string
    field :phone, :string, default: nil
  end
end

defmodule MyApp.EmbeddedData do
  use Ecto.Schema

  embedded_schema do
    embeds_one :order, Lunaris.Orders.NewOrder
    embeds_one :customer, Lunaris.Orders.Customer
  end
end

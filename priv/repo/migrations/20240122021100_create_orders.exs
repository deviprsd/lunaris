defmodule Lunaris.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :paid, :decimal
      add :currency, :string
      add :point_percentage, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end

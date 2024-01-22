defmodule Lunaris.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :paid, :decimal
      add :currency, :string
      add :point_percentage, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end

defmodule Lunaris.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :phone, :string
      add :balance, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end

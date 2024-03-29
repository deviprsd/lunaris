defmodule Lunaris.Repo.Migrations.OrderBelongsToCustomer do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :customer_id, references(:customers), null: false
    end
  end
end

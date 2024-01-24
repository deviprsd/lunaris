defmodule Lunaris.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Lunaris.Repo

  alias Lunaris.Orders.Order

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id) |> Repo.preload([:customer])

  @doc """
  Creates a order.

  ## Examples

      iex> create_order!(%{field: value})
      %Order{}

      iex> create_order!(%{field: bad_value})
      error

  """
  def create_order!(attrs \\ %{}) do
    %Order{}
    |> change_order(attrs)
    |> Repo.insert!()
    |> Repo.preload(:customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end
end

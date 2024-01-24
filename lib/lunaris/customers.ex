defmodule Lunaris.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false
  alias Lunaris.Customers.CustomerRequest
  alias Lunaris.Repo

  alias Lunaris.Customers.Customer

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the Customer does not exist.

  ## Examples

      iex> get_customer!(123)
      %Customer{}

      iex> get_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer!(id), do: Repo.get!(Customer, id)

  def search_customer!(query) do
    changeset =
      %CustomerRequest{}
      |> CustomerRequest.changeset(query)

    if changeset.valid? do
      changes = changeset.changes
      email = Map.get(changes, :email, nil)
      phone = Map.get(changes, :phone, nil)
      email_or_phone = if email, do: email, else: phone

      Repo.one!(
        from c in Customer,
          where: c.email == ^email_or_phone or c.phone == ^email_or_phone
      )
    else
      raise Ecto.InvalidChangesetError, action: :search, changeset: changeset
    end
  end

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> change_customer(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a balance.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_balance(customer_id, points_awarded) do
    Customer
    |> where(id: ^customer_id)
    |> update(inc: [balance: ^points_awarded])
    |> Repo.update_all([])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{data: %Customer{}}

  """
  def change_customer(%Customer{} = customer, attrs \\ %{}) do
    Customer.changeset(customer, attrs)
  end
end

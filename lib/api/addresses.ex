defmodule Api.Addresses do
  @moduledoc """
  The Addresses context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Addresses.Address

  @doc """
  Returns the list of adresses of user.

  ## Examples

      iex> list_adresses(user_id)
      [%Address{}, ...]

  """
  def list_adresses(user_id) do
    Repo.all_by(Address, user_id: user_id)
  end

  @doc """
  Gets a single address of user.

  Raises `Ecto.NoResultsError` if the Address does not exist.

  ## Examples

      iex> get_address!(123, 1)
      %Address{}

      iex> get_address!(456, 1)
      ** (Ecto.NoResultsError)

  """
  def get_address!(user_id, id), do: Repo.get!(Address, id: id, user_id: user_id)

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(user_id, attrs) do
    %Address{}
    |> Address.changeset(attrs, user_id)
    |> Repo.insert()
  end

  @doc """
  Updates a address.

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_address(user_id, %Address{} = address, attrs) do
    true = address.user_id == user_id

    address
    |> Address.changeset(attrs, user_id)
    |> Repo.update()
  end

  @doc """
  Deletes a address.

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_address(user_id, %Address{} = address) do
    true = address.user_id == user_id
    Repo.delete(address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking address changes.

  ## Examples

      iex> change_address(address)
      %Ecto.Changeset{data: %Address{}}

  """
  def change_address(%Address{} = address, attrs \\ %{}) do
    Address.changeset(address, attrs)
  end
end

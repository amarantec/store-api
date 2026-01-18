defmodule ApiWeb.AddressJSON do
  alias Api.Addresses.Address

  @doc """
  Renders a list of adresses.
  """
  def index(%{adresses: adresses}) do
    %{data: for(address <- adresses, do: data(address))}
  end

  @doc """
  Renders a single address.
  """
  def show(%{address: address}) do
    %{data: data(address)}
  end

  defp data(%Address{} = address) do
    %{
      id: address.id,
      street: address.street,
      number: address.number,
      zip: address.zip,
      city: address.city
    }
  end
end

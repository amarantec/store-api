defmodule Api.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Addresses` context.
  """
  @doc """
  Generate a address.
  """
  def address_fixture(user_id, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        city: "some city",
        number: "1",
        street: "some street",
        zip: "12345678"
    })
    {:ok, address} = Api.Addresses.create_address(user_id, attrs)
    address
  end
end

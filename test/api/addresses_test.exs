defmodule Api.AddressesTest do
  use Api.DataCase

  alias Api.Addresses

  describe "adresses" do
    alias Api.Addresses.Address

    import Api.AddressesFixtures
    import Api.AccountsFixtures

    @invalid_attrs %{zip: nil, number: nil, street: nil, city: nil}

    test "list_adresses/1 returns all adresses" do
      user = user_fixture()
      address = address_fixture(user.id)
      assert Addresses.list_adresses(user.id) == [address]
    end

    test "get_address!/2 returns the address with given id" do
      user = user_fixture()
      address = address_fixture(user.id)
      assert Addresses.get_address!(user.id, address.id) == address
    end

    test "create_address/2 with valid data creates a address" do
      user = user_fixture()
      valid_attrs = %{
        zip: "12345678",
        number: "1",
        street: "some street",
        city: "some city"
      }

      assert {:ok, %Address{} = address} = Addresses.create_address(user.id, valid_attrs)
      assert address.zip == "12345678"
      assert address.number == "1"
      assert address.street == "some street"
      assert address.city == "some city"
    end

    test "create_address/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(user.id, @invalid_attrs)
    end

    test "update_address/3 with valid data updates the address" do
      user = user_fixture()
      address = address_fixture(user.id)
      update_attrs = %{
        zip: "12345678",
        number: "1",
        street: "some updated street",
        city: "some updated city"
      }

      assert {:ok, %Address{} = address} = Addresses.update_address(user.id, address, update_attrs)
      assert address.zip == "12345678"
      assert address.number == "1"
      assert address.street == "some updated street"
      assert address.city == "some updated city"
    end

    test "update_address/3 with invalid data returns error changeset" do
      user = user_fixture()
      address = address_fixture(user.id)
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(user.id, address, @invalid_attrs)
      assert address == Addresses.get_address!(user.id, address.id)
    end

    test "delete_address/2 deletes the address" do
      user = user_fixture()
      address = address_fixture(user.id)
      assert {:ok, %Address{}} = Addresses.delete_address(user.id, address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(user.id, address.id) end
    end

    test "change_address/1 returns a address changeset" do
      user = user_fixture()
      address = address_fixture(user.id)
      assert %Ecto.Changeset{} = Addresses.change_address(user.id, address)
    end
  end
end

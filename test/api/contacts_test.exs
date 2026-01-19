defmodule Api.ContactsTest do
  use Api.DataCase

  alias Api.Contacts

  describe "contacts" do
    alias Api.Contacts.Contact

    import Api.ContactsFixtures
    import Api.AccountsFixtures
    
    @invalid_attrs %{ddi: nil, ddd: nil, phone_number: nil}

    test "list_contacts/1 returns all contacts" do
      user = user_fixture()
      contact = contact_fixture(user.id)
      assert Contacts.list_contacts(user.id) == [contact]
    end

    test "get_contact!/2 returns the contact with given id" do
      user = user_fixture()
      contact = contact_fixture(user.id)
      assert Contacts.get_contact!(user.id, contact.id) == contact
    end

    test "create_contact/2 with valid data creates a contact" do
      valid_attrs = %{ddi: "012", ddd: "210", phone_number: "987654321"}
      user = user_fixture()
      assert {:ok, %Contact{} = contact} = Contacts.create_contact(user.id, valid_attrs)
      assert contact.ddi == "012"
      assert contact.ddd == "210"
      assert contact.phone_number == "987654321"
    end

    test "create_contact/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Contacts.create_contact(user.id, @invalid_attrs)
    end

    test "update_contact/3 with valid data updates the contact" do
      user = user_fixture()
      contact = contact_fixture(user.id)
      update_attrs = %{ddi: "012", ddd: "210", phone_number: "987654321", user_id: user.id}

      assert {:ok, %Contact{} = contact} = Contacts.update_contact(user.id, contact, update_attrs)
      assert contact.ddi == "012"
      assert contact.ddd == "210"
      assert contact.phone_number == "987654321"
    end

    test "update_contact/3 with invalid data returns error changeset" do
      user = user_fixture()
      contact = contact_fixture(user.id)
      assert {:error, %Ecto.Changeset{}} = Contacts.update_contact(user.id, contact, @invalid_attrs)
      assert contact == Contacts.get_contact!(user.id, contact.id)
    end

    test "delete_contact/2 deletes the contact" do
      user = user_fixture()
      contact = contact_fixture(user.id)
      assert {:ok, %Contact{}} = Contacts.delete_contact(user.id, contact)
      assert_raise Ecto.NoResultsError, fn -> Contacts.get_contact!(user.id, contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      user = user_fixture()
      contact = contact_fixture(user.id)
      assert %Ecto.Changeset{} = Contacts.change_contact(user.id, contact)
    end
  end
end

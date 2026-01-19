defmodule Api.ContactsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Contacts` context.
  """

  @doc """
  Generate a contact.
  """
  def contact_fixture(user_id, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
      ddd: "012",
      ddi: "210",
      phone_number: "987654321",
    })
  {:ok, contact} = Api.Contacts.create_contact(user_id, attrs)
  contact
  end
end

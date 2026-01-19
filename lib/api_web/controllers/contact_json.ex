defmodule ApiWeb.ContactJSON do
  alias Api.Contacts.Contact

  @doc """
  Renders a list of contacts.
  """
  def index(%{contacts: contacts}) do
    %{data: for(contact <- contacts, do: data(contact))}
  end

  @doc """
  Renders a single contact.
  """
  def show(%{contact: contact}) do
    %{data: data(contact)}
  end

  defp data(%Contact{} = contact) do
    %{
      id: contact.id,
      ddi: contact.ddi,
      ddd: contact.ddd,
      phone_number: contact.phone_number
    }
  end
end

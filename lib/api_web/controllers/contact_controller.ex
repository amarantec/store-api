defmodule ApiWeb.ContactController do
  use ApiWeb, :controller

  alias Api.Contacts
  alias Api.Contacts.Contact

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    user = conn.assigns.current_user
    contacts = Contacts.list_contacts(user.id)
    render(conn, :index, contacts: contacts)
  end

  def create(conn, %{"contact" => contact_params}) do
    user = conn.assigns.current_user
    with {:ok, %Contact{} = contact} <- Contacts.create_contact(user.id, contact_params) do
      conn
      |> put_status(:created)
      |> render(:show, contact: contact)
    end
  end

  def show(conn, %{"id" => id}) do
    user = conn.assigns.current_user
    contact = Contacts.get_contact!(user.id, id)
    render(conn, :show, contact: contact)
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = Contacts.get_contact!(id)
    user = conn.assigns.current_user
    with {:ok, %Contact{} = contact} <- Contacts.update_contact(user.id, contact, contact_params) do
      render(conn, :show, contact: contact)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Contacts.get_contact!(id)
    user = conn.assigns.current_user
    with {:ok, %Contact{}} <- Contacts.delete_contact(user.id, contact) do
      send_resp(conn, :no_content, "")
    end
  end
end

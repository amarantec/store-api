defmodule ApiWeb.AddressController do
  use ApiWeb, :controller

  alias Api.Addresses
  alias Api.Addresses.Address


  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    user = conn.assigns.current_user
    adresses = Addresses.list_adresses(user.id)
    render(conn, :index, adresses: adresses)
  end

  def create(conn, %{"address" => address_params}) do
    user = conn.assigns.current_user

    with {:ok, %Address{} = address} <- Addresses.create_address(user.id, address_params) do
      conn
      |> put_status(:created)
      |> render(:show, address: address)
    end
  end

  def show(conn, %{"id" => id}) do
    user = conn.assigns.current_user
    address = Addresses.get_address!(user.id, id)
    render(conn, :show, address: address)
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    address = Addresses.get_address!(id)
    user = conn.assigns.current_user

    with {:ok, %Address{} = address} <- Addresses.update_address(user.id, address, address_params) do
      render(conn, :show, address: address)
    end
  end

  def delete(conn, %{"id" => id}) do
    address = Addresses.get_address!(id)
    user = conn.assigns.current_user

    with {:ok, %Address{}} <- Addresses.delete_address(user.id, address) do
      send_resp(conn, :no_content, "")
    end
  end
end

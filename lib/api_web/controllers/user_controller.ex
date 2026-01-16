defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.User
  alias Api.Guardian

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _full_claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render(:show, user: user, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

   def sign_in(conn, %{"user" => %{"email" => email, "hash_password" => hash_password}}) do
    case Api.Guardian.authenticate(email, hash_password) do
      {:ok, user, token} ->
        conn
        |> put_status(:ok)
        |> render(:show, user: user, token: token)

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render(:error, error: "invalid credentials")
    end
  end

  def reset_password(conn, %{"user" => user_params}) do
    case Accounts.get_user_by_email(user_params["email"]) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> render(:error, error: "Email not found")

      user ->
        case Api.Guardian.validate_password(user_params["current_password"], user.hash_password) do
          true ->
            with {:ok, %User{} = user} <- Accounts.update_user(user, user_params),
                 {:ok, token, _full_claims} <- Api.Guardian.encode_and_sign(user) do
              render(conn, :show, user: user, token: token)
            end

          false ->
            conn
            |> put_status(:unauthorized)
            |> render(:error, error: "invalid credentials")
        end
    end
  end
end

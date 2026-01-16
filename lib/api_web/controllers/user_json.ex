defmodule ApiWeb.UserJSON do
  alias Api.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user, token: token}) do
    %{data: data(user, token)}
  end

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
    }
  end

  def error(%{error: error}) do
    %{
      error: error
    }
  end
end

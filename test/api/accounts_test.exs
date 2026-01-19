defmodule Api.AccountsTest do
  use Api.DataCase
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Accounts

  describe "users" do
    alias Api.Accounts.User

    import Api.AccountsFixtures

    @invalid_attrs %{email: nil, hash_password: nil, role: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "email@test.com", hash_password: "123456", role: "customer"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == "email@test.com"
      assert String.length(user.hash_password) > 50
      refute user.hash_password == "123456"
      assert user.role == "customer"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "email@test.com", hash_password: "123456", role: "customer"}
      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "email@test.com"
      assert user.role == "customer"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end

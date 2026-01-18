defmodule Api.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :hash_password, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end

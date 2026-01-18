defmodule Api.Repo.Migrations.CreateAdresses do
  use Ecto.Migration

  def change do
    create table(:adresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :street, :string
      add :number, :string
      add :zip, :string
      add :city, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:adresses, [:user_id])
  end
end

defmodule Api.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "adresses" do
    field :street, :string
    field :number, :string
    field :zip, :string
    field :city, :string
    belongs_to :user, Api.Accounts.User

    timestamps(type: :utc_datetime)
  end

	@digits_regex ~r/^\d+$/
	
  @doc false
  def changeset(address, attrs, user_id) do
    address
    |> cast(attrs, [:street, :number, :zip, :city])
    |> validate_required([:street, :number, :zip, :city], message: "Please fill out this field")
    |> validate_format(:number, @digits_regex, message: "Address Number must contain only digits (0-9)")
    |> validate_format(:zip, @digits_regex, message: "Address ZIP must contain only digits (0-9)")
    |> validate_length(:zip, is: 8, message: "Address ZIP must contain 8 digits")
    |> put_change(:user_id, user_id)
  end
end

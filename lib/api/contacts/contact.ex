defmodule Api.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contacts" do
    field :ddi, :string
    field :ddd, :string
    field :phone_number, :string
    belongs_to :user, Api.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @digits_regex ~r/^\d+$/
  
  @doc false
  def changeset(contact, attrs, user_id) do
    contact
    |> cast(attrs, [:ddi, :ddd, :phone_number])
    |> validate_required([:ddi, :ddd, :phone_number])
    |> validate_format(:ddi, @digits_regex,
      message: "DDI number must contain only digits (0-9)"
    )
    |> validate_length(:ddi, is: 3, message: "DDI number must contain 3 digits")
    |> validate_format(:ddd, @digits_regex,
      message: "DDD number must contain only digits (0-9)"
    )
    |> validate_length(:ddd, is: 3, message: "DDD number must contain 3 digits")
    |> validate_format(:phone_number, @digits_regex,
      message: "Phone NUmber must contain only digits (0-9)"
    )
    |> validate_length(:phone_number, is: 9, message: "Phone Number must contain 9 digits")
    |> put_change(:user_id, user_id)
  end
end

defmodule Api.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :description, :string
    field :image_url, :string
    field :price, :decimal
    belongs_to :category, Api.Categories.Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :image_url, :price, :category_id])
    |> validate_required([:name, :description, :image_url, :price, :category_id])
  end
end

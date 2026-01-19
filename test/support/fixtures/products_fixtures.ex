defmodule Api.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Products` context.
  """
  import Api.CategoriesFixtures
  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    category = category_fixture()

    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        price: "120.5",
        category_id: "#{category.id}"
      })
      |> Api.Products.create_product()

    product
  end
end

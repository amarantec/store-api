defmodule Api.ProductsTest do
  use Api.DataCase

  alias Api.Products

  describe "products" do
    alias Api.Products.Product

    import Api.ProductsFixtures
    import Api.CategoriesFixtures
    
    @invalid_attrs %{name: nil, description: nil, image_url: nil, price: nil, category_id: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      category = category_fixture()
      valid_attrs = %{
        name: "some name",
        description: "some description",
        image_url: "some image_url",
        price: "120.5",
        category_id: "#{category.id}"
      }

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.image_url == "some image_url"
      assert product.price == Decimal.new("120.5")
      assert product.category_id == category.id
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      category = category_fixture()
      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        image_url: "some updated image_url",
        price: "456.7",
        category_id: "#{category.id}"
      }

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.image_url == "some updated image_url"
      assert product.price == Decimal.new("456.7")
      assert product.category_id == category.id
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end

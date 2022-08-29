require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    # validation tests/examples here    

    it 'category name should be Test' do
      @category = Category.new(name: "Test")
      @test_product = Product.new(name: "Product")
      expect(@category.name).to be == "Test"

    end
    it 'category name should not be equal to anything else' do
      @category = Category.new(name: "Test")
      @test_product = Product.new(name: "Product")
      expect(@category.name).not_to be == "incorrect"
    end
    it 'product name should be Product' do
      @category = Category.new(name: "Test")
      @test_product = Product.new(name: "Product")
      expect(@test_product.name).to be == "Product"
    end
    it 'product price should not exist' do
      @category = Category.new(name: "Test")
      @test_product = Product.new(name: "Product")
      expect(@test_product.price).to be_nil
    end
    it 'When name is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'

      # @product.name = "test"
      @product.price_cents = 1234
      @product.quantity = 1
      @product.category = @category

      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'When price is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'

      @product.name = "test"
      # @product.price_cents = 1234
      @product.quantity = 1
      @product.category = @category

      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'When quantity is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'

      @product.name = "test"
      @product.price_cents = 1234
      # @product.quantity = 1
      @product.category = @category

      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'When category is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'

      @product.name = "test"
      @product.price_cents = 1234
      @product.quantity = 1
      # @product.category = @category

      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
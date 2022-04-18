require 'rails_helper'
require 'pp'

RSpec.describe Product, type: :model do

  # @category = Category.new(name: 'Test')
  # @product = @category.products.new({
  #   name: "Test Product",
  #   price: 9.99,
  #   quantity: 1
  # })

  describe 'Validations' do
    it "is valid with valid attributes" do
      @category = Category.new(name: 'Test')
      @product = @category.products.new({
        name: 'Test Product',
        price: 9.99,
        quantity: 1
      })
      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      @category = Category.new(name: 'Test')
      @product = @category.products.new({
        name: nil,
        price: 9.99,
        quantity: 1
      })

      expect(@product).to_not be_valid
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a price" do
      @category = Category.new(name: 'Test')
      @product = @category.products.new({
        name: "Test Product",
        price: nil,
        quantity: 1
      })

      expect(@product).to_not be_valid
      expect(@product.errors[:price]).to include("can't be blank")
    end

    it "is not valid without a quantity" do
      @category = Category.new(name: 'Test')
      @product = @category.products.new({
        name: "Test Product",
        price: 9.99,
        quantity: nil
      })

      expect(@product).to_not be_valid
      expect(@product.errors[:quantity]).to include("can't be blank")
    end

    it "is not valid without a category" do
      @product = Product.new({
        name: 'Test Product',
        price: 9.99,
        quantity: 1,
        category: nil
      })

      expect(@product).to_not be_valid
      expect(@product.errors[:category]).to include("can't be blank")
    end
  end

end

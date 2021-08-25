require 'rails_helper'
require 'product'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do

      @category = Category.new(:name => "Electronics")
      

      @product = Product.new({:id => 1, :name => "Steve", :quantity => 5, :price => 10000})
    end    


    it 'Should have a name' do
        expect(@product.name).to be_present
    end
    
    it 'Should have a Price' do
      expect(@product.price).to be_present
    end
    
    it 'Should have a quantity' do
      expect(@product.quantity).to be_present
    end
    
    it 'Should have a id' do
      expect(@product.id).to be_present
    end

  end
end

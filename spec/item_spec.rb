require 'rspec'
require './lib/item'

describe Item do
  before(:each) do
    @item = Item.new({name: 'Peach', price: "$0.75"})
  end

  describe "#initialize" do
    it 'is an instance of item' do
      expect(@item).to be_instance_of(Item)
      expect(@item.name).to eq('Peach')
      expect(@item.price).to eq(0.75)
    end
  end
end
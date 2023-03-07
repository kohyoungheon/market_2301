require 'rspec'
require './lib/vendor'

describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe "#initialize" do
    it 'is an instance of Vendor' do
      expect(@vendor).to be_instance_of(Vendor)
      expect(@vendor.name).to eq('Rocky Mountain Fresh')
      expect(@vendor.inventory).to eq({})
    end
  end

  describe "#check_stock" do
    it 'returns 0 if item is not in stock' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end

    it 'checks given item stock' do
      @vendor.stock(@item1, 30)
      @vendor.stock(@item2, 15)

      expect(@vendor.check_stock(@item1)).to eq(30)
      expect(@vendor.check_stock(@item2)).to eq(15)
    end
  end

  describe "#stock" do
    it 'stocks the given item at given quantity' do
      expect(@vendor.inventory).to eq({})

      @vendor.stock(@item1, 30)
      expect(@vendor.inventory).to eq({@item1 => 30})

      @vendor.stock(@item2, 10)
      expect(@vendor.inventory).to eq({@item1 => 30, @item2 => 10})
    end
  end
end
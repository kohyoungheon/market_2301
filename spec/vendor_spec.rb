require 'rspec'
require './lib/vendor'
require './lib/item'

describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
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

      @vendor.stock(@item1, 20)
      expect(@vendor.inventory).to eq({@item1 => 50, @item2 => 10})

      expect(@vendor.check_stock(@item1)).to eq(50)
      expect(@vendor.check_stock(@item2)).to eq(10)
    end
  end

  describe '#potential_revenue' do
    it 'returns sum of all item price * quantity' do
      @vendor2.stock(@item1, 10)
      expect(@vendor2.potential_revenue).to eq(7.50)

      @vendor2.stock(@item2, 10)
      expect(@vendor2.potential_revenue).to eq(12.50)

      @vendor3.stock(@item3, 100)
      expect(@vendor3.potential_revenue).to eq(530)

      @vendor3.stock(@item4, 100)
      expect(@vendor3.potential_revenue).to eq(955)
    end
  end

end
require 'rspec'
require './lib/market'

describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market") 
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  describe '#initialize' do
    it 'is an instance of Market' do
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to eq([])
    end
  end

  describe '#add_vendor' do
    it 'can add a vendor to market' do
      expect(@market.vendors).to eq([])

      @market.add_vendor(@vendor1)
      expect(@market.vendors).to eq([@vendor1])

      @market.add_vendor(@vendor2)
      expect(@market.vendors).to eq([@vendor1, @vendor2])
    end
  end

  describe '#vendor_names' do
    it 'returns a list of vendor names' do
      expect(@market.vendor_names).to eq([])

      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#vendors_that_sell' do
    it 'returns a list of vendors that sell the given item' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors_that_sell(@item1)).to eq([])

      @vendor1.stock(@item1, 35)
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1])

      @vendor2.stock(@item1, 5)
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor2])

      expect(@market.vendors_that_sell(@item2)).to eq([])

      @vendor2.stock(@item2 , 20)
      expect(@market.vendors_that_sell(@item2)).to eq([@vendor2])

      @vendor3.stock(@item2 , 10)
      expect(@market.vendors_that_sell(@item2)).to eq([@vendor2, @vendor3])
    end
  end

  describe '#sorted_item_list' do
    it 'returns a list of all items alphabetically sorted' do
      @vendor1.stock(@item1, 5)
      @vendor1.stock(@item2, 10)
      @vendor2.stock(@item3, 50)
      @vendor3.stock(@item4, 15)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end

    it 'can exclude duplicates' do
      @vendor1.stock(@item2, 5)
      @vendor1.stock(@item3, 5)

      @vendor2.stock(@item3, 50)
      @vendor2.stock(@item4, 50)

      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)

      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  describe '#total_inventory' do
    it 'returns the quantity of all items sold in market' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)

      @vendor1.stock(@item1, 5)
      expect(@market.total_inventory).to eq({@item1 => {:quantity => 5, :vendors => [@vendor1]}})
      
      @vendor1.stock(@item2, 10)
      expect(@market.total_inventory).to eq({@item1 => {:quantity => 5, :vendors => [@vendor1]}, 
                                             @item2 => {:quantity => 10, :vendors => [@vendor1]}})
      @vendor2.stock(@item1, 50)
      expect(@market.total_inventory).to eq({@item1 => {:quantity => 55, :vendors => [@vendor1, @vendor2]}, 
                                             @item2 => {:quantity => 10, :vendors => [@vendor1]}})

      @vendor2.stock(@item2, 30)
       expect(@market.total_inventory).to eq({@item1 => {:quantity => 55, :vendors => [@vendor1, @vendor2]}, 
                                              @item2 => {:quantity => 40, :vendors => [@vendor1,@vendor2]}})
    end
  end

  describe '#overstocked_items' do
    it 'returns a list of overstocked items' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.overstocked_items).to eq([])

      @vendor1.stock(@item1, 60)
      expect(@market.overstocked_items).to eq([])

      @vendor2.stock(@item1, 1)
      expect(@market.overstocked_items).to eq([@item1])

      @vendor1.stock(@item2, 10)
      @vendor2.stock(@item2, 10)
      @vendor3.stock(@item2, 10)
      expect(@market.overstocked_items).to eq([@item1])

      @vendor3.stock(@item2, 21)
      expect(@market.overstocked_items).to eq([@item1, @item2])
    end
  end
end
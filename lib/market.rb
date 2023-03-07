class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end
  
  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    vendors_list = []
    @vendors.each do |vendor|
      if vendor.inventory[item] != 0
        vendors_list << vendor
      end
    end
    vendors_list
  end

  def sorted_item_list()
    item_array = []
    @vendors.each do |vendor|
      vendor.inventory.each do |key, value|
        item_array << key.name
      end
    end
    item_array.uniq.sort
  end

end

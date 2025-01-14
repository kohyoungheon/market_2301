class Vendor
  attr_reader :name, :inventory
  
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    if @inventory.include?(item)
      @inventory[item]
    else
      0
    end
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def potential_revenue
    total = 0
    @inventory.each do |key, value|
      total += (key.price * value)
    end
    total
  end

end

class Item
  attr_reader :name, :price

  def initialize(infohash)
    @name = infohash[:name]
    @price = infohash[:price].delete('$').to_f
  end
  
end

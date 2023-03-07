require 'rspec'
require './lib/vendor'

describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  describe "#initialize" do
    it 'is an instance of Vendor' do
      expect(@vendor).to be_instance_of(Vendor)
      expect(@vendor.name).to eq('Peach')
      expect(@vendor.inventory).to eq({})
    end
  end
end
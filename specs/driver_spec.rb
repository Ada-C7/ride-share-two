require_relative 'spec_helper'

describe "Driver tests" do
  let(:driver) { Driver.new({ id: 4, name: "Ada", vin: "1XKAD49X2DJ395724" }) }

  describe "Driver#initialize" do
    it "Takes an ID, name, and VIN" do
      driver.must_respond_to :id
      driver.id.must_equal 4

      driver.must_respond_to :name
      driver.name.must_equal "Ada"

      driver.must_respond_to :vin
      driver.vin.must_equal "1XKAD49X2DJ395724"
    end
  end
end

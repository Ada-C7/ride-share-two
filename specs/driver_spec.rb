require_relative "spec_helper"
require_relative "../lib/driver"

describe "class Driver" do
  describe "Driver#initialize" do

    it "Takes an id, name and vehicle number" do
      id = "007"
      name = "James Bond"
      vin = "WBWSS52P9NEYLVDE9"
      driver1 = RideSharing::Driver.new(id, name, vin)

      driver1.must_respond_to :id
      driver1.id.must_equal id

      driver1.must_respond_to :name
      driver1.name.must_equal name

      driver1.must_respond_to :vin
      driver1.vin.must_equal vin

    end
  end
end

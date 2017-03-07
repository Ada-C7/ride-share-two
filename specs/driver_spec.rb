require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver" do

  describe "#initialize" do
    it "Takes an ID, name, and vin" do
      name = "Bob Belcher"
      id = 12345
      vin = 98765
      driver = Driver.new(id, name, vin)

      driver.must_respond_to :id
      driver.id.must_equal id

      driver.must_respond_to :name
      driver.name.must_equal name

      driver.must_respond_to :vin
      driver.vin.must_equal vin
    end

    it "Is a kind of Driver" do
      name = "Bob Belcher"
      id = 12345
      vin = 98765
      driver = Driver.new(id, name, vin)

      driver.must_be_kind_of Driver
    end
  end
end

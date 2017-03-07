require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver.rb'

describe Driver do
  describe "initialize" do
    it "takes an id, name, and VIN" do
      id = 5
      name = "Marisol Rosales"
      vin = "WBWSS52P9NEYLVDE9"
      driver = Driver.new(id, name, vin)
    end
  end
end

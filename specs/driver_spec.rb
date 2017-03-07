# require 'csv'
require_relative '../specs/spec_helper.rb'

describe "Driver" do

  describe "Driver#initialize" do
    before do
      id = 1
      name = "Bernardo Prosacco"
      vin = "WBWSS52P9NEYLVDE9"
      @new_driver = RideShare::Driver.new(id, name, vin)
    end

    it "Should create an instance of Driver" do
      @new_driver.must_respond_to :id
      @new_driver.id.must_equal id
      @new_driver.must_respond_to :name
      @new_driver.name.must_equal name
    end

    # describe "tests" do
    #   it "should run some tests" do
    #     true.must_equal false
    #   end
  end
end

require 'csv'

require_relative '../specs/spec_helper.rb'
# require_relative '../lib/driver'

describe "Driver" do

  describe "Driver#initialize" do

    let(:new_driver) {RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")}

    it "Should create an instance of Driver" do
      new_driver.must_be_instance_of RideShare::Driver
    end

    it "Should be associated with :id and :name" do
      new_driver.must_respond_to(:id)
      new_driver.must_respond_to :name
    end

    it "Should create instances of drivers and their associated data" do
      RideShare::Driver.all.must_be_kind_of Array
    end
    
    it "Returns an id from CSV" do
      RideShare::Driver.find(1).id.must_equal(1)
      # let (:new_driver) {Rideshare::Driver.find(1)}
      # new_driver.find(1).id.must_equal(1)
      # @new_driver.id.must_equal 1
      # new_id.find(2)
      # new_id.must_equal 2
      # accounts = RideShare::Driver.all.find(8)
      # # new_id = RideShare::Driver.find(8)
      # accounts.id.must_equal 8
    end
  end
end

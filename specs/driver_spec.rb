require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver tests" do
  describe "Driver#initialize" do
    it "takes an id, name, and vin" do
        new_driver = Driver.new("3", "Bob Jones", "12345")

        new_driver.must_respond_to :id
        new_driver.id.must_equal "3"

        new_driver.must_respond_to :name
        new_driver.name.must_equal "Bob Jones"

        new_driver.must_respond_to :vin
        new_driver.vin.must_equal "12345"
    end
  end

end

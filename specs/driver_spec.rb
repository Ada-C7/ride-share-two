require_relative 'spec_helper'

describe "Driver class" do

  it "is an instance of Driver" do
    test_driver = Driver.new({id: 1, name: "George", vehicle_id: 3313})
    test_driver.must_be_kind_of Driver
  end

  describe "Initialize method" do
    it "" do

    end
  end

  describe "get_trips method" do
    it "" do

    end
  end

  describe "average_rating method" do
    it "" do

    end
  end

  describe "self.all method" do
    it "" do

    end
  end

  describe "self.find(id) method" do
    it "" do

    end
  end

end

require_relative 'spec_helper'

describe "Driver class" do

  it "is an instance of Driver" do
    test_driver = Driver.new({id: 1, name: "George", vehicle_id: 3313})
    test_driver.must_be_kind_of Driver
  end

  describe "Initialize method" do
    it "" do
      # nada?
    end
  end

  describe "get_trips method" do
    it "returns an array" do

    end
    it "all elements are Trip instances" do

    end
    it "all Trips in array have same driver_id as id passed in" do

    end
  end

  describe "average_rating method" do
    it "returns a float" do

    end
    it "is >= 1" do

    end
    it "is <= 5" do

    end
  end

  describe "self.all method" do
    it "returns an array" do

    end
    it "all elements are Driver instances" do

    end
  end

  describe "self.find(id) method" do
    it "returns a Driver instance" do

    end
    it "Driver's id matches the id passed in" do

    end
  end

end

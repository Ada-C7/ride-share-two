require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/rider.rb'
require_relative '../specs/spec_helper.rb'

describe Rider do
  describe "initialize" do
    it "takes a name, id, and phone number" do
      name = "Marisol Bravo"
      id = "5"
      phone_number = "562-328-7865"
      rider = Rider.new(name, id, phone_number)
      rider.must_be_instance_of Rider
      rider.name.must_equal name
      rider.id.must_equal id
      rider.phone_number.must_equal phone_number
    end
  end
  describe "self.all" do

    before do
      @csv_rider = Rider.all
    end

    it "checks for an array" do
      @csv_rider.must_be_instance_of Array
    end
    it "checks every array is instance of Rider" do #this is checking for riders
      @csv_rider.each do |array|
        array.must_be_instance_of Rider
      end
    end
    it "checks correct length of csv driver file" do
      @csv_rider.length.must_equal 301
    end

  end
end

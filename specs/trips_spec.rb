require_relative 'spec_helper'
require 'pry'


describe "Trip" do
  let(:my_trip) {RideShare::Trip.new(1, 2, 3, 4, 5)}
  let(:all_trips) {RideShare::Trip.find_all}
  let(:csv) {CSV.read("support/trips.csv")}

  describe "Trip#initialize" do
    it "takes an ID, Driver ID, Rider ID, Date and Rating to initialize" do
      my_trip.must_respond_to :id
    end

    it "rating must be between 1 - 5" do
      proc {RideShare::Trip.new(1, 2, 3, 4, 17)}.must_raise InvalidRatingError
    end
  end

  describe "Testing Trip class methods" do
    it "returns an array of Trip instances" do
      all_trips.must_be_instance_of(Array)
    end

    it "each item is of class Trip" do
      all_trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "number of owners matches number of lines in CSV - 1 for headder line" do
      csv_length = csv.length
      all_trips.length.must_equal(csv_length - 1)
    end

    it "date of first & last match date of first & last in CSV" do
      all_trips[0].date.must_equal(csv[1][3])
      all_trips[-1].date.must_equal(csv[-1][3])
    end
  end

end

require_relative 'spec_helper'

describe "Trip" do
  let(:my_trip) {RideShare::Trip.new(1, 2, 3, 4, 5)}
  let(:all_trips) {RideShare::Trip.find_all}

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

  end

end

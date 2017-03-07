require_relative 'spec_helper'

describe "Trip" do

  describe "Trip#initialize" do
    it "takes an ID, Driver ID, Rider ID, Date and Rating to initialize" do
      my_trip = RideShare::Trip.new(1, 2, 3, 4, 5)
      my_trip.must_respond_to :id
    end

    it "rating must be between 1 - 5" do
      proc {RideShare::Trip.new(1, 2, 3, 4, 17)}.must_raise InvalidRatingError
    end
  end


end

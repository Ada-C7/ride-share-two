require_relative 'spec_helper'

# Also if you weren't already testing for it, there are a bunch of invalid trip lines in the csv file that will make trip objects with driver ids that don't exist
describe "Trip" do

  describe "initialize" do
    it "Raises an ArgumentError when the rating is less than 1" do
      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: 3, rider_id: 3, date: 2016-01-13, rating: 0)
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError when the rating is greater than 5" do
      proc {
        RideShare::Trip.new(trip_id: 1, driver_id: 2, rider_id: 2, date: 2016-02-13, rating: 6)
      }.must_raise ArgumentError
    end
  end

  describe "create_all_trips" do

  end



end

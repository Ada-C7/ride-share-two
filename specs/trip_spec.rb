require_relative 'spec_helper'

describe "Trip Initialize" do

    it "Takes an ID, Rider ID, Driver ID, date, and a rating" do
      trip_id = 1337
      rider_id = 318
      driver_id = 54
      date = "date"
      rating = 4
      trip = RideShareTwo::Trip.new(trip_id, rider_id, driver_id, date, rating)

      trip.must_respond_to :trip_id
      trip_id.must_equal trip_id

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal rider_id

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal driver_id

      trip.must_respond_to :date
      trip.date.must_equal date

      trip.must_respond_to :rating
      trip.rating.must_equal rating
    end

    it "Raises an ArgumentError if the rating is greater than 5" do
      proc {
        RideShareTwo::Trip.new(1337, 318, 54, "date", 6)
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError if the rating is 0" do
      proc {
        RideShareTwo::Trip.new(1337, 318, 54, "date", 0)
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError if the rating is less than 0" do
      proc {
        RideShareTwo::Trip.new(1337, 318, 54, "date", -3)
      }.must_raise ArgumentError
    end

end

# from here below, these are ng

# describe "Trip_Driver" do
#     it "Retrieves the associated trip driver instance through the driver ID" do
#       trip_id = 1337
#       rider_id = 318
#       driver_id = 54
#       date = "date"
#       rating = 4
#       trip = RideShareTwo::Trip.new(trip_id, rider_id, driver_id, date, rating)
#
#       trip.driver_id.must_equal 54
#     end
# end
#
# describe "Trip_Rider" do
#     it "Retrieves the associated trip rider instance through the rider ID" do
#       trip_id = 1337
#       rider_id = 318
#       driver_id = 54
#       date = "date"
#       rating = 4
#       trip = RideShareTwo::Trip.new(trip_id, rider_id, driver_id, date, rating)
#
#       trip.rider_id.must_equal 318
#     end
# end

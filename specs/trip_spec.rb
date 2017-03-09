require_relative 'spec_helper'

describe "Trip class" do
  let(:trip)  {RideShare::Trip.new(15, 26, 143, "2016-06-17", 5
    )}
    describe "#initialize method" do
      it "Initializes a new trip instance from the parameter" do
        trip.must_be_instance_of RideShare::Rider
        trip.must_respond_to :id
        trip.id.must_equal trip[:id]
        trip.must_respond_to :driver_id
        trip.driver_id.must_equal trip[:driver_id]
        trip.must_respond_to :rider_id
        trip.rider_id.must_equal trip[:rider_id]
        trip.must_respond_to :date
        trip.date.must_equal trip[:date]
        trip.must_respond_to :rating
        trip.rating.must_equal trip[:rating]
      end

      it "raises an argument error if Trip's ID or driver id or rider id or date are invalid" do
        proc {
          RideShare::Trip.new(one, 26, 143, "2016-06-17", 5)
        }.must_raise ArgumentError
        proc {
          RideShare::Trip.new(1, twenty, 143, "2016-06-17", 5)
        }.must_raise ArgumentError
        proc {
          RideShare::Trip.new(1, 26, [143], "2016-06-17", 5)
        }.must_raise ArgumentError
        proc {
          RideShare::Trip.new(1, 26, 143, 16|06|17, 5)
        }.must_raise ArgumentError
      end

        it "raises an invalid rating error if rating is not an integer between 1 and 5" do
          proc {
            RideShare::Trip.new(1, 26, 143, "2016-06-17", 9)
          }.must_raise InvalidRatingError
        end
      end
  end

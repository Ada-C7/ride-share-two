require_relative 'spec_helper'

describe "RideShare Module" do
  describe "Trip class" do
    let(:first_trip) {RideShare::Trip.new(1, 1, 54, '2016-04-05', 3)}
    let(:last_trip) {RideShare::Trip.new(600, 61, 168, '2016-04-25', 3)}
    let(:random_trip) {RideShare::Trip.new(393, 98, 290, '2015-08-22', 5)}
    let(:trip) {RideShare::Trip}

    describe "Trip#initialize" do
      it "Takes an trip ID, driver ID, rider ID, date and rate" do
        id_t = 16
        id_d = 25
        id_r = 259
        date = '2016-05-25'
        rating = 5

        trip_ins = trip.new(id_t, id_d, id_r, date, rating)

        trip_ins.must_respond_to :id_t
        trip_ins.id_t.must_equal id_t

        trip_ins.must_respond_to :id_d
        trip_ins.id_d.must_equal id_d

        trip_ins.must_respond_to :id_r
        trip_ins.id_r.must_equal id_r

        trip_ins.must_respond_to :date
        trip_ins.date.must_equal date

        trip_ins.must_respond_to :rating
        trip_ins.rating.must_equal rating
      end

      it "Creates a new instance of Trip class" do
        random_trip.class.must_equal RideShare::Trip
        first_trip.class.must_equal RideShare::Trip
        last_trip.class.must_equal RideShare::Trip
      end

      it "Raises ArgumentErrors if the parameters are not the right ones" do
        proc {
          trip.new("1", 4, 6 , "4-3-2042", 4)
        }.must_raise ArgumentError
        proc {
          trip.new(-1, 4, 6 , "4-3-2042", 4)
        }.must_raise ArgumentError
        proc {
          trip.new(1, "4", 6 , "4-3-2042", 4)
        }.must_raise ArgumentError
        proc {
          trip.new(1, -4, 6 , "4-3-2042", 4)
        }.must_raise ArgumentError
        proc {
          trip.new(1, 4, "6" , "4-3-2042", 4)
        }.must_raise ArgumentError
        proc {
          trip.new(1, 4, -6 , "4-3-2042", 4)
        }.must_raise ArgumentError
        proc {
          trip.new(1, 4, 6 , 4-3-2042, 4)
        }.must_raise ArgumentError
      end

      it "Raises ArgumentError if rate is not a number between 1 and 5" do
        proc {
          trip.new(393, 98, 290, '2015-08-22', '5')
        }.must_raise ArgumentError
        proc {
          trip.new(393, 98, 290, '2015-08-22', 0)
        }.must_raise ArgumentError
        proc {
          trip.new(393, 98, 290, '2015-08-22', 6)
        }.must_raise ArgumentError
      end
    end#end of Trip#initialize

    describe "Trip#self.all" do
      it "returns an array" do
        trip.all.must_be_instance_of Array
      end

      it "The returned array is filled with Trip instances" do
        trip.all.first.must_be_instance_of RideShare::Trip
        trip.all.last.must_be_instance_of RideShare::Trip
        trip.all[384].must_be_instance_of RideShare::Trip
      end

      it "Has all the trip instances from CSV file" do
        trip.all.length.must_equal 600
      end

      it "Contain the first, random and last trip information" do
        trip.all[0].id_t.must_equal first_trip.id_t
        trip.all[0].id_d.must_equal first_trip.id_d
        trip.all[0].id_r.must_equal first_trip.id_r
        trip.all[0].date.must_equal first_trip.date
        trip.all[0].rating.must_equal first_trip.rating
        trip.all[392].id_t.must_equal random_trip.id_t
        trip.all[392].id_d.must_equal random_trip.id_d
        trip.all[392].id_r.must_equal random_trip.id_r
        trip.all[392].date.must_equal random_trip.date
        trip.all[392].rating.must_equal random_trip.rating
        trip.all[599].id_t.must_equal last_trip.id_t
        trip.all[599].id_d.must_equal last_trip.id_d
        trip.all[599].id_r.must_equal last_trip.id_r
        trip.all[599].date.must_equal last_trip.date
        trip.all[599].rating.must_equal last_trip.rating
      end
    end#end of method all

    describe "Trip#self.trips_made_by_driver" do
      it "Returns an array filled with Trip instances" do
        trip.trips_made_by_driver(1).must_be_instance_of Array

        trip.trips_made_by_driver(1).first.must_be_instance_of RideShare::Trip
        trip.trips_made_by_driver(1).last.must_be_instance_of RideShare::Trip
      end

      it "Returns an empty array if driver does not have any trips" do
        trip.trips_made_by_driver(600).must_be_empty
      end

      it "Raises an ArgumentError if parameter is not a positive Integer" do
        proc {
          trip.trips_made_by_driver("1")
        }.must_raise ArgumentError
        proc {
          trip.trips_made_by_driver(-1)
        }.must_raise ArgumentError
      end

      it "Returns the right amount of trips made by the driver" do
        trip.trips_made_by_driver(1).length.must_equal 9
      end
    end#end of self.trips_made_by_driver method

    describe "Trip#self.trips_taken_by_rider" do
      it "Returns an array filled with Trip instances" do
        trip.trips_taken_by_rider(1).must_be_instance_of Array

        trip.trips_taken_by_rider(1).first.must_be_instance_of RideShare::Trip
        trip.trips_taken_by_rider(1).last.must_be_instance_of RideShare::Trip
      end

      it "Returns an empty array if rider does not have any trips" do
        trip.trips_taken_by_rider(300).must_be_empty
      end

      it "Raises an ArgumentError if parameter is not a positive Integer" do
        proc {
          trip.trips_taken_by_rider("1")
        }.must_raise ArgumentError
        proc {
          trip.trips_taken_by_rider(-1)
        }.must_raise ArgumentError
      end

      it "Returns the right amount of trips made by the rider" do
        trip.trips_taken_by_rider(1).length.must_equal 2
      end
    end#end of self.trips_taken_by_rider method

    describe "Trip#driver" do
      it "Returns an instance of Driver class" do
        first_trip.driver.must_be_instance_of RideShare::Driver
      end

      it "Returns the right Driver instance" do
        first_trip.driver.vin.must_equal "WBWSS52P9NEYLVDE9"
        random_trip.driver.name_d.must_equal "Ms. Winston Emard"
        last_trip.driver.id_d.must_equal 61
      end

      it "Returns message if id_d does not exist" do
        trip1 = trip.new(1, 1000, 54, '2016-04-05', 3)
        trip1.driver.class.must_equal String
      end

      it "Raises ArgumentError if Driver's Id no an Integer" do
        proc {
          trip.new(1, "1000", 54, '2016-04-05', 3).driver
        }.must_raise ArgumentError
      end
    end

    describe "Trip#rider" do
      it "Returns an instance of Rider class" do
        first_trip.rider.must_be_instance_of RideShare::Rider
      end

      it "Returns the right Rider instance" do
        first_trip.rider.phone_number.must_equal "591-707-1595 x0908"
        random_trip.rider.name_r.must_equal "Quinn Tillman"
        last_trip.rider.id_r.must_equal 168
      end

      it "Returns message if id_r does not exist" do
        trip1 = trip.new(1, 1, 5400, '2016-04-05', 3)
        trip1.rider.class.must_equal String
      end

      it "Raises ArgumentError if Rider's Id no an Integer" do
        proc {
          trip.new(1, 1, "54", '2016-04-05', 3).rider
        }.must_raise ArgumentError
      end
    end
  end#end of Trip class
end#end of the Module RideShare

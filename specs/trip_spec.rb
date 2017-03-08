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

      it "Creater a new instance of Trip class" do
        random_trip.class.must_equal RideShare::Trip
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

      it "Contain the first, random and last trip information" do
        trip.all[0].id_t.must_equal first_trip.id_t
        trip.all[0].id_d.must_equal first_trip.id_d
        trip.all[0].id_r.must_equal first_trip.id_r
        trip.all[0].rating.must_equal first_trip.rating
        trip.all[392].id_t.must_equal random_trip.id_t
        trip.all[392].id_d.must_equal random_trip.id_d
        trip.all[392].id_r.must_equal random_trip.id_r
        trip.all[392].rating.must_equal random_trip.rating
        trip.all[599].id_t.must_equal last_trip.id_t
        trip.all[599].id_d.must_equal last_trip.id_d
        trip.all[599].id_r.must_equal last_trip.id_r
        trip.all[599].rating.must_equal last_trip.rating
      end
    end#end of method all

    describe "Trip#self.trips_made_by_driver" do
      it "Returns an array filled with Trip instances" do
        trip.trips_made_by_driver(1).must_be_instance_of Array

        trip.trips_made_by_driver(1).first.must_be_instance_of RideShare::Trip
        trip.trips_made_by_driver(1).last.must_be_instance_of RideShare::Trip
        # trip.trips_made_by_driver(600).first.must_be_instance_of RideShare::Trip
      end

      it "" do

      end
      # let(:first_trip) {RideShare::Trip.new(1, 1, 54, '2016-04-05', 3)}
      # let(:last_trip) {RideShare::Trip.new(600, 61, 168, '2016-04-25', 3)}
      # let(:random_trip) {RideShare::Trip.new(393, 98, 290, '2015-08-22', 5)}
      # let(:trip) {RideShare::Trip}

    end
  end#end of Trip class
end#end of the Module RideShare

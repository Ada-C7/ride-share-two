require_relative 'spec_helper'

describe "Trip" do
  describe "initialize" do

    let(:valid_trip) {Rideshare::Trip.new({ trip_id: 1,driver_id: 2,rider_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:no_driver_trip) {Rideshare::Trip.new({ trip_id: 1,rider_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:no_rider_trip) {Rideshare::Trip.new({ trip_id: 1, driver_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:no_trip_id) {Rideshare::Trip.new({ driver_id: 1,rider_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:weird_rating) {Rideshare::Trip.new({ trip_id: 1, driver_id: 1,rider_id: 3,date: "today",rating: 0 }, :trip_id) }


    it "has a driver id, rider id, trip id, date, rating a name of the right types" do
      valid_trip.driver_id.must_be_kind_of Integer
      valid_trip.rider_id.must_be_kind_of Integer
      valid_trip.trip_id.must_be_kind_of Integer
      valid_trip.date.must_be_kind_of String
    end

    it "properly stores the search variable as :id" do
      valid_trip.id.must_equal valid_trip.trip_id
    end

    it "raises an argument error if driver_id, trip_id, or rider_id are missing" do
      proc{no_driver_trip}.must_raise ArgumentError
      proc{no_rider_trip}.must_raise ArgumentError
      proc{no_trip_id}.must_raise ArgumentError
    end

    it "outputs a warning if :rating is outside acceptable range" do
      proc{weird_rating}.must_output /.+/
    end
  end

  describe "all" do
    let(:all_trips) {Rideshare::Trip.all(:trip_id)}

    it "returns a collection with right number of rows" do
      all_trips.length.must_equal 595
    end

    it 'works for the first trip in the csv' do
      all_trips.first.trip_id.must_equal 1
      all_trips.first.driver_id.must_equal 1
      all_trips.first.rider_id.must_equal 54
      all_trips.first.date.must_equal "2016-04-05"
      all_trips.first.rating.must_equal 5
    end

    it 'works for the last trip in the csv' do
      all_trips.last.trip_id.must_equal 600
      all_trips.last.driver_id.must_equal 61
      all_trips.last.rider_id.must_equal 168
      all_trips.last.date.must_equal "2016-04-25"
      all_trips.last.rating.must_equal 3
    end

    describe "find_records" do
      let(:first_trip) {Rideshare::Trip.find_records(:trip_id, 1)}

      let(:last_trip) {Rideshare::Trip.find_records(:trip_id, 600)}

      let(:imaginary_trip) {Rideshare::Trip.find_records(:trip_id, 601)}

      let(:first_driver_trips) {Rideshare::Trip.find_records(:driver_id, 1)}

      let(:last_driver_trips) {Rideshare::Trip.find_records(:driver_id, 99)}

      let(:first_rider_trips) {Rideshare::Trip.find_records(:rider_id, 1)}

      let(:last_rider_trips) {Rideshare::Trip.find_records(:rider_id, 99)}

      # let(:double_driver) {Rideshare::Driver.find_records(':driver_id, 94)}


      it 'works for the first trip in the csv' do
        first_trip[0].trip_id.must_equal 1
        first_trip[0].driver_id.must_equal 1
        first_trip[0].rider_id.must_equal 54
        first_trip[0].date.must_equal "2016-04-05"
        first_trip[0].rating.must_equal 5
      end

      it 'works for the last trip in the csv' do
        last_trip[0].trip_id.must_equal 600
        last_trip[0].driver_id.must_equal 61
        last_trip[0].rider_id.must_equal 168
        last_trip[0].date.must_equal "2016-04-25"
        last_trip[0].rating.must_equal 3
      end

      it "returns only one trip for first and last" do
        last_trip.length.must_equal 1
        first_trip.length.must_equal 1
      end

      it "returns empty array if the trip does not exist" do
        imaginary_trip.must_be_empty
      end

      it "returns the correct trips for the first driver" do

        first_driver_trips.length.must_equal 9

        trip_ids = []
        first_driver_trips.each do |trip|
          trip_ids << trip.trip_id.to_i
        end
        trip_ids.sort.must_equal [1, 122, 124, 216, 417, 434, 439, 530, 553]
      end


      it "returns the correct trips for the first rider" do

        first_rider_trips.length.must_equal 2

        trip_ids = []
        first_rider_trips.each do |trip|
          trip_ids << trip.trip_id.to_i
        end
        trip_ids.sort.must_equal [46, 272]
      end

      it "returns the correct trips for the last rider" do

        last_rider_trips.length.must_equal 3

        trip_ids = []
        last_rider_trips.each do |trip|
          trip_ids << trip.trip_id.to_i
        end
        trip_ids.sort.must_equal [345, 509, 577]
      end
    end
  end
end

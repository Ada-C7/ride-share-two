require_relative 'spec_helper'

describe "Trip" do
  describe "initialize" do

    let(:ok_rider) {Rideshare::Rider.new({ rider_id: 1, name: "Ms. Acceptable Rider",phone_num: "555-555-5555"}, :rider_id) }

    let(:no_name_rider) {Rideshare::Rider.new({ rider_id: 1, phone_num: "555-555-5555"} ) }

    let(:no_id_rider) {Rideshare::Rider.new({ name: "Mr. Mystery ID",  phone_num: "555-555-5555"} ) }

    let(:no_phone_rider) {Rideshare::Rider.new({ rider_id: 1, name: "Dr. No Digits"}, :rider_id) }


    it "creates instance variables rider id, name, and phone_num with proper formatting " do
      ok_rider.rider_id.must_be_kind_of Integer
      ok_rider.name.must_be_kind_of String
      ok_rider.phone_num.must_be_kind_of String
    end

    it "properly stores the search variable as :id" do
      ok_rider.id.must_equal ok_rider.rider_id
    end

    it "raises an argument error if rider_id, name, or phone_num are missing" do
      proc{no_name_rider}.must_raise ArgumentError
      proc{no_id_rider}.must_raise ArgumentError
      proc{no_phone_rider}.must_raise ArgumentError
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

  end
end

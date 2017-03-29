require_relative 'spec_helper'

describe "Driver" do
  describe "initialize" do
    let(:ok_driver) {Rideshare::Driver.new( { driver_id: 1, name: "OK Driver", vin: "1234567890123456B" }, :driver_id )}

    let(:bad_vin_2short) {
      proc{
        Rideshare::Driver.new({driver_id: 1, name: "Ms. Short Vin", vin: "123456789012345B"}, :driver_id)
      }
    }

    let(:bad_vin_2long) {
      proc {
        Rideshare::Driver.new({driver_id: 1, name: "Ms. Long Vin", vin: "12345678901234567B"}, :driver_id)
      }
    }

    let(:bad_id) {
      proc{
        Rideshare::Driver.new({id: 'b', name: "Miss No ID", vin: "12345678901234567"}, :driver_id)}
      }

      let(:no_name) {
        proc{Rideshare::Driver.new({name: "", vin: "12345678901234567"}, :driver_id)}
      }

      it "has a driver id, a name of the right types" do
        ok_driver.driver_id.must_be_kind_of Integer
        ok_driver.vin.must_be_kind_of String
        ok_driver.name.must_be_kind_of String
      end

      it "raises an argument error if the vin isn't right" do
        bad_vin_2short.must_raise VinError
        bad_vin_2long.must_raise VinError
      end


      it "raises an argument error if name is not entered" do
        no_name.must_raise ArgumentError
      end
    end


    describe "all" do
      let(:all_drivers) {Rideshare::Driver.all(:driver_id)}

      it "returns a collection with right number of rows" do
        all_drivers.length.must_equal 99
      end

      it "returns values of the correct class (and no nil values)" do
        all_drivers.each do |driver|
          driver.must_be_kind_of Rideshare::Driver
          driver.driver_id.must_be_kind_of Integer
          driver.vin.must_be_kind_of String
          driver.name.must_be_kind_of String
        end
      end

      it 'has a test value from the csv' do
        all_drivers[3].name.must_equal "Jeromy O'Keefe DVM"
      end
    end

    describe "find_driver" do
      let(:first_driver) {Rideshare::Driver.find_records(:driver_id, 1)}

      let(:last_driver) {Rideshare::Driver.find_records(:driver_id, 100)}

      let(:imaginary_driver) {Rideshare::Driver.find_records(:driver_id, 500)}

      # let(:double_driver) {Rideshare::Driver.find_records(':driver_id, 94)}


      it "finds the first driver from the csv using their numeric ID" do
        first_driver[0].name.must_equal "Bernardo Prosacco"
        first_driver[0].vin.must_equal "WBWSS52P9NEYLVDE9"
      end

      it "finds the last driver from the csv using their numeric ID" do
        last_driver[0].name.must_equal "Minnie Dach"
        last_driver[0].vin.must_equal "XF9Z0ST7X18WD41HT"
      end

      it "returns only one driver for first and last" do
        last_driver.length.must_equal 1
        first_driver.length.must_equal 1
      end

      it "returns empty array if the driver does not exist" do
        imaginary_driver.must_be_empty
      end
    end

    describe "subset_driver_trips" do
      let(:first_driver_trips) {Rideshare::Driver.subset_driver_trips(1)}

      let(:last_driver_trips) {Rideshare::Driver.subset_driver_trips(99)}


      it "returns the correct trips for the first driver" do

        first_driver_trips.length.must_equal 9

        trip_ids = []
        first_driver_trips.each do |trip|
          trip_ids << trip.trip_id.to_i
        end
        trip_ids.sort.must_equal [1, 122, 124, 216, 417, 434, 439, 530, 553]
      end


      it "returns the correct trips for the last driver" do

        last_driver_trips.length.must_equal 6

        trip_ids = []
        last_driver_trips.each do |trip|
          trip_ids << trip.trip_id.to_i
        end
        trip_ids.sort.must_equal [54, 86, 230, 420, 423, 531]
      end

    end


    describe "get_driver_rating" do

      let(:first_driver_rating) {Rideshare::Driver.get_driver_rating(1)}

      let(:last_driver_rating) {Rideshare::Driver.get_driver_rating(99)}

      let(:non_driving_rating) { Rideshare::Driver.get_driver_rating(100)}



      it "correctly calculates the average rating for the first driver based on all trips taken" do
        first_driver_rating.must_equal 2.3
      end

      it "correctly calculates the average rating for the last driver based on all trips taken" do
        last_driver_rating.must_equal 2.8
      end

      it "returns nil and outputs a warning if the driver has not done any trips yet" do
        non_driving_rating.must_be_nil
        proc{Rideshare::Driver.get_driver_rating(100)}.must_output /.+/
      end

      it "outputs a warning and " do
        non_driving_rating.must_be_nil
        proc{Rideshare::Driver.get_driver_rating(100)}.must_output /.+/
      end
    end
  end

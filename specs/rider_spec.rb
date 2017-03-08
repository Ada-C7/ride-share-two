require_relative 'spec_helper'
require_relative '../lib/rider'

describe "Rider class" do
  let (:rider_hash) { { id: 93, name: "Kaylie Okuneva IV", phone_number: "(170) 751-2406" } }
  let (:rider)  { RideShare::Rider.new(rider_hash) }

  describe "#initialize method" do
    it "Initializes a new rider instance from the parameter" do
      rider.must_be_instance_of RideShare::Rider
      rider.must_respond_to :id
      rider.id.must_equal rider_hash[:id]
      rider.must_respond_to :name
      rider.name.must_equal rider_hash[:name]
      rider.must_respond_to :phone_number
      rider.phone_number.must_equal rider_hash[:phone_number]
    end

    it "Raises an argument error if the rider_hash parameter is incomplete" do
      proc {
        RideShare::Rider.new({})
      }.must_raise ArgumentError

      proc {
        RideShare::Rider.new({ name: "Kaylie Okuneva IV", phone_number: "(170) 751-2406" })
      }.must_raise ArgumentError

      proc {
        RideShare::Rider.new({ nick_name: "Betsy", phone_number: "(170) 751-2406" })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the parameter is not hash" do
      proc {
        RideShare::Rider.new()
      }.must_raise ArgumentError

      proc {
        RideShare::Rider.new("93, Kaylie Okuneva IV, (170) 751-2406")
      }.must_raise ArgumentError
    end
  end

  describe "#trips method" do

    let (:trips_by_rider) { rider.trips }

    it "Retrieve the list of trip instances that only this rider has taken" do
      trips_by_rider.must_be_instance_of Array
      trips_by_rider.length.must_equal 3
      trips_by_rider.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "First element inside the returned array matches the CSV file" do
        trip = trips_by_rider.first
        trip.id.must_equal 162
        trip.driver_id.must_equal 6
        trip.rider_id.must_equal 93
        trip.date.must_equal "2015-03-09"
        trip.rating.must_equal 4
    end

    it "The last element inside the returned array matches the CSV file" do
      trip = trips_by_rider.last
      if trip != nil
        trip.id.must_equal 184
        trip.driver_id.must_equal 75
        trip.rider_id.must_equal 93
        trip.date.must_equal "2016-04-01"
        trip.rating.must_equal 2
      end
    end
  end

  describe "#drivers method" do

    let (:drivers) { rider.drivers }

    it "Retrieve the list of all previous driver instances" do
      drivers.must_be_instance_of Array
      drivers.length.must_equal 3
      drivers.each { |driver| driver.must_be_instance_of RideShare::Driver }
    end

    it "First element inside the returned array matches the CSV file" do
        driver = drivers.first
        driver.id.must_equal 6
        driver.name.must_equal "Mr. Hyman Wolf"
        driver.vin.must_equal "L1CXMYNZ3MMGTTYWU"
    end

    it "The last element inside the returned array matches the CSV file" do
      driver = drivers.last
      if driver != nil
        driver.id.must_equal 75
        driver.name.must_equal "Mohammed Barrows"
        driver.vin.must_equal "4RACJHJL843CUJ46R"
      end
    end
  end

  let (:all_riders_array) { RideShare::Rider.all }

  describe "#self.all method" do
    it "Retrieve all riders from the CSV file" do
      all_riders_array.must_be_instance_of Array
      all_riders_array.length.must_equal 300
      all_riders_array.each { |rider| rider.must_be_instance_of RideShare::Rider }
    end

    it "First element inside the returned array matches the CSV file" do
      rider = all_riders_array.first
      rider.id.must_equal 1
      rider.name.must_equal "Nina Hintz Sr."
      rider.phone_number.must_equal "560.815.3059"
    end

    it "Last element inside the returned array matches the CSV file" do
      rider = all_riders_array.last
      rider.id.must_equal 300
      rider.name.must_equal "Miss Isom Gleason"
      rider.phone_number.must_equal "791-114-8423 x70188"
    end
  end

  describe "#self.find method" do
    it "Find a specific rider using their numeric ID" do
      rider = RideShare::Rider.find(93)
      rider.must_be_instance_of RideShare::Rider
      rider.id.must_equal 93
      rider.name.must_equal "Kaylie Okuneva IV"
      rider.phone_number.must_equal "(170) 751-2406"
    end
    it "Raises an argument error when invalid rider id is passed" do
      proc{
        RideShare::Rider.find("ninetythree")
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the rider id does not have a match in the rider.csv" do
      proc{
        RideShare::Rider.find(123456789)
      }.must_raise ArgumentError
    end
  end
end

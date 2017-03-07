require_relative 'spec_helper'

describe "Rider class" do
  let(:rider_hash) {{rider_id: 32, name: "Natalia", phone:  "1425394958"}}
  let(:rider_hash2) {{rider_id: 90000, name: "Natalia", phone:  "1425394958"}}
  let(:rider) {RideShare::Rider.new(rider_hash)}
  let(:rider2) {RideShare::Rider.all[3]}
  let(:rider3) {RideShare::Rider.new(rider_hash2)}
  let(:all_riders) {RideShare::Rider.all}

  describe "Rider#initialize" do
    it "Creates new instance of Rider class"do
    rider.class.must_equal RideShare::Rider
    end
    it "Has rider id, name and phone as initial values" do
      rider.must_respond_to :rider_id
      rider.must_respond_to :name
      rider.must_respond_to :phone
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc {
        RideShare::Rider.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Raise ArgumentError if passing name contains not letter or . or '  " do
      proc {
        hash = {rider_id: 32, name: "Na434talia", phone:  "1425394958"}
        RideShare::Rider.new(hash)
      }.must_raise ArgumentError
    end
    it "Raise ArgumentError if passing rider id is not an integer " do
      proc {
        hash = {rider_id: "32", name: "Natalia", phone:  "1425394958"}
        RideShare::Rider.new(hash)
      }.must_raise ArgumentError
    end
    it "Raise ArgumentError if passing phone is not an integer" do
      proc {
        hash = {rider_id: 32,  name: "Natalia", phone:  1425394958}
        RideShare::Rider.new(hash)
      }.must_raise ArgumentError
    end
  end # end of initialize method test

  describe "Rider#all_rider_trips" do
    it "Return an array"do
      # rider = RideShare::Rider.all[3]
      rider2.all_rider_trips.class.must_equal Array
    end
    it "Returned array must contain object(s) of class Trip" do
      # rider = RideShare::Rider.all[3]
      rider2.all_rider_trips.each do |trip|
        trip.class.must_equal RideShare::Trip
      end
    end
    it "Returned empty array if there is no trip associated
    with this rider id" do
      # rider3 = RideShare::Rider.new(rider_hash2)
      rider3.all_rider_trips.must_be_empty
    end
  end # end of all_rider_trips test

  describe "Rider#all_rider_drivers" do
    it "Returns array" do
      # rider = RideShare::Rider.all[25]
      rider2.all_rider_drivers.class.must_equal Array
    end
    it "Returns empty array if rider is not found" do
      # rider = RideShare::Rider.new(rider_hash2)
      rider3.all_rider_drivers.must_be_empty
    end
    it "Returns array that has object(s) of class Driver" do
      # rider = RideShare::Rider.all[25]
      rider2.all_rider_drivers.each do |driver|
        driver.class.must_equal RideShare::Driver
      end
    end
    it "Driver id of returned driver must be the same as in CSV file" do
      csv = CSV.read("support/trips.csv", 'r')
      rider = RideShare::Rider.all[25]#(rider_id = 26)
      actual_driver_id = rider.all_rider_drivers[0].driver_id
      expected_driver_id = csv[103][1].to_i
      actual_driver_id.must_equal expected_driver_id
    end
  end # end of all_rider_drivers test

  describe "Rider#all" do
    it "Rider.all returns an array" do
      all_riders.must_be_kind_of Array
    end
    it "Everything in the array is an Rider class" do
      # all_riders = RideShare::Rider.all
      all_riders.each do |rider|
        rider.must_be_kind_of RideShare::Rider
      end
    end
    it " The number of riders is correct" do
      # all_riders = RideShare::Rider.all
      all_riders.length.must_equal 300
    end
    it "The ID, name and phone of the first and last
      riders match what's in the CSV file" do
      csv = CSV.read("support/riders.csv", 'r')
      expected_id_first = csv[1][0].to_i
      expected_name_first = csv[1][1]
      expected_phone_first = csv[1][2]
      expected_id_last = csv[300][0].to_i
      expected_name_last = csv[300][1]
      expected_phone_last = csv[300][2]
      # all_riders = RideShare::Rider.all

      all_riders[0].rider_id.must_equal expected_id_first
      all_riders[0].name.must_equal expected_name_first
      all_riders[0].phone.must_equal expected_phone_first
      all_riders[299].rider_id.must_equal expected_id_last
      all_riders[299].name.must_equal expected_name_last
      all_riders[299].phone.must_equal expected_phone_last
    end
  end # end of all method

  describe "Rider.find" do
    it "Returns a rider that exists" do
      result = RideShare::Rider.find(16)
      result.must_be_kind_of RideShare::Rider
    end

    it "Can find the first rider from the CSV" do
      csv = CSV.read("support/riders.csv", 'r')
      result = RideShare::Rider.find(csv[1][0].to_i)
      result.rider_id.must_equal RideShare::Rider.all[0].rider_id
      result.name.must_equal RideShare::Rider.all[0].name
      result.phone.must_equal RideShare::Rider.all[0].phone
    end

    it "Can find the last rider from the CSV" do
      csv = CSV.read("support/riders.csv", 'r')
      result = RideShare::Rider.find(csv[300][0].to_i)
      result.rider_id.must_equal RideShare::Rider.all[299].rider_id
      result.name.must_equal RideShare::Rider.all[299].name
      result.phone.must_equal RideShare::Rider.all[299].phone
    end

    it "Raises an error for a rider that doesn't exist" do
      proc {
        RideShare::Rider.find(3000)
      }.must_raise ArgumentError
    end
  end # end of find method

end # end of class

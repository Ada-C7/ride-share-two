require_relative 'spec_helper'
require_relative "../ride_share"
require "csv"

describe "Rider Class" do
  describe "Rider#initialize" do
    let(:rana) { RideShare::Rider.new(name: 'Rana', rider_id: "2", phone_num: "4255667897" )}
    it "Takes an ID , name and phone number" do

      rana.must_respond_to :id
      rana.id.must_equal "2"

      rana.must_respond_to :name
      rana.name.must_equal "Rana"

      rana.must_respond_to :phone_number
      rana.phone_number.must_equal "4255667897"
    end
  end

  describe "Rider#all" do
    let(:all_riders) { RideShare::Rider.all}

    it "Check that class have an all method" do
      RideShare::Rider.must_respond_to :all
    end

    it "Returns an array of all rider instances" do
      all_riders.must_be_kind_of Array
    end

    it 'Everything in the array is an instane of Ride_share::Rider class' do
      all_riders.each do |rider_instance|
        rider_instance.must_be_instance_of RideShare::Rider
      end
    end

    it "The number of rider records = 300, records in csv file" do
      all_riders.length.must_equal 300
    end

    it "The ID and name and phone number of the first rider match what's in the CSV file" do
      # 1,Nina Hintz Sr.,560.815.3059
      rider_id = "1"
      name = "Nina Hintz Sr."
      phone_number = "560.815.3059"

      all_riders.first.id.must_equal rider_id
      all_riders.first.name.must_equal name
      all_riders.first.phone_number.must_equal phone_number
    end

    it "The ID and name and phone number of the last rider match what's in the CSV file" do
      # 300,Miss Isom Gleason,791-114-8423 x70188

      rider_id = "300"
      name = "Miss Isom Gleason"
      phone_number = "791-114-8423 x70188"

      all_riders.last.id.must_equal rider_id
      all_riders.last.name.must_equal name
      all_riders.last.phone_number.must_equal phone_number
    end
  end
  describe "Rider#find" do

    it "Check that class have a find method" do
      RideShare::Rider.must_respond_to :find
    end

    it "Returns a rider instance with correct data " do
      # 28,Earlene Bogan,1-295-646-5152
      rider_id = "28"
      rider = RideShare::Rider.find(rider_id)
      #rider.must_be_instance_of RideShare::Rider
      rider.id.must_equal '28'
      rider.name.must_equal 'Earlene Bogan'
      rider.phone_number.must_equal '1-295-646-5152'
    end

    it "Returns nil when rider id not in the database" do
      rider_id = "9999"
      RideShare::Rider.find(rider_id).must_equal nil
    end

    it "Returns nil when rider id is not string type" do
      rider_id = 99292
      RideShare::Rider.find(rider_id).must_equal nil
    end
  end
  describe "Rider#retrieve_trips" do

    it "Check that class have a retrieve_trips method" do
      rider = RideShare::Rider.new(name: 'Rana', rider_id: "2", phone_num: "425343" )
      rider.must_respond_to :retrieve_trips
    end

    it "The length of trips list is the same count as in csv file" do
      specific_rider_id = "54"
      trips = RideShare::Trip.find_rider_trips(specific_rider_id)
      trips.length.must_equal 2
    end

    it "Returns the list of trip instances for a specific rider" do
      specific_rider_id = "54"
      trips = RideShare::Trip.find_rider_trips(specific_rider_id)
      trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end
  end
end

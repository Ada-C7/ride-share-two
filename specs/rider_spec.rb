require_relative 'spec_helper'
require_relative "../ride_share"
require "csv"
describe "Rider Class" do
  describe "Rider#initialize" do
    let(:rana) { Ride_Share::Rider.new(name: 'Rana', rider_id: "2", phone_num: "4255667897" )}
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
    let(:all_riders) { Ride_Share::Rider.all}

    it "Returns an array of all rider instances" do
      all_riders.must_be_kind_of Array
    end

    it 'Everything in the array is an instane of Ride_share::Rider class' do
      all_riders.each do |rider_instance|
        rider_instance.must_be_instance_of Ride_Share::Rider
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
      Ride_Share::Rider.must_respond_to :find
    end

    it "Returns a rider instance with correct data " do
      # 28,Earlene Bogan,1-295-646-5152
      rider_id = "28"
      rider = Ride_Share::Rider.find(rider_id)
      #rider.must_be_instance_of Ride_Share::Rider
      rider.name.must_equal 'Earlene Bogan'
      rider.phone_number.must_equal '1-295-646-5152'
    end

    it "Raises an argument error with rider id not in the data base" do
      rider_id = "9999"
      proc { Ride_Share::Rider.find(rider_id) }.must_raise ArgumentError
    end

  end

end

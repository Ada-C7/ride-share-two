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

  # describe "#trips method" do
  #   it "Retrieve the list of trip instances that only this rider has taken" do
  #     trips_by_rider = rider.trips.class
  #     trips_by_rider.must_equal Array
  #     trips_by_rider.length.must_equal 3
  #   end
  #
  #   it "" do
  #
  #   end
  # end
  #
  # describe "#drivers method" do
  #   it "Retrieve the list of all previous driver instances" do
  #
  #   end
  #
  # end
  #
  # describe "#self.all method" do
  #   it "Retrieve all riders from the CSV file" do
  #
  #   end
  # end
  #
  # describe "#self.find method" do
  #   it "Find a specific rider using their numeric ID" do
  #
  #   end
  # end
end

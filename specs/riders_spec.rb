require_relative 'spec_helper'

describe "rider_id" do
  let(:my_rider) {RideShare::Rider.new(1, 2, 3)}
  let(:trips_csv) {CSV.read("support/trips.csv")}

  describe "Diver#initialize" do
    it "takes an ID, Name, and Phone Number to initialize" do
      my_rider.must_respond_to :id
      my_rider.must_respond_to :name
      my_rider.must_respond_to :phone
    end
  end

  describe "Rider#trips" do
    it "returns an array of trips that this rider has taken" do
      my_rider.trips.must_be_instance_of Array
    end

    it "each item is of class Trip" do
      my_rider.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "trips.length matches number of trips from CSV file for that rider" do
      trips_number = my_rider.trips.length
      lines_from_csv = []
      trips_csv.each do |line|
        if line[2].to_i == my_rider.id
          lines_from_csv << line
        end
      end
      lines_from_csv.length.must_equal trips_number
    end

    it "Returns 0 if driver is not found" do
      bad_id = RideShare::Rider.new(901291029102, "Nope", "Nope")
      bad_id.trips.must_equal 0
    end
  end

  # Leaving this to continue to build out rest of driver and trips
  # describe "Rider#drivers" do
  #   it "Retrieve a list of all previous driver instances this rider has rode with" do
  #     my_rider.drivers.must_be_instance_of Array
  #   end
  # end

end

require_relative 'spec_helper'

describe "rider_id" do
  let(:my_rider) {RideShare::Rider.new(1, 2, 3)}
  let(:trips_csv) {CSV.read("support/trips.csv")}
  let(:all_riders) {RideShare::Rider.find_all}
  let(:riders_csv) {CSV.read("support/riders.csv")}

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

    it "trips.length matches number of trips from CSV file" do
      trips_number = my_rider.trips.length
      lines_from_csv = []
      trips_csv.each do |line|
        if line[2].to_i == my_rider.id
          lines_from_csv << line
        end
      end
      lines_from_csv.length.must_equal trips_number
    end

    it "Returns 0 if rider is not found" do
      bad_id = RideShare::Rider.new(901291029102, "Nope", "Nope")
      bad_id.trips.must_equal 0
    end

    it "Returns 0 if rider has not had a trip" do
      no_trips = RideShare::Rider.new(300, "Miss Isom Gleason", "791-114-8423 x70188")
      no_trips.trips.must_equal 0
    end
  end

  describe "Rider#drivers" do
    it "Retrieve an array of all previous driver instances for this rider" do
      my_rider.drivers.must_be_instance_of Array
      my_rider.drivers[0].must_be_instance_of RideShare::Driver
      my_rider.drivers[-1].must_be_instance_of RideShare::Driver
    end

    it "Returns accurate drivers associated with trips" do
      drivers = my_rider.drivers
      first_driver_id = drivers[0].id

      trips = my_rider.trips
      first_driver_id_trip = trips[0].driver_id

      first_driver_id.must_equal first_driver_id_trip
    end

    it "Returns unique list of Drivers" do
      rider = RideShare::Rider.new(250, "Kylie Cartwright", "734.297.0789 x3288")
      drivers = rider.drivers
      driver_ids = drivers.map { |driver| driver.id }
      driver_ids.uniq!.must_be_nil
    end
  end

  describe "find_all Rider class method" do
    it "returns an array of Rider instances" do
      all_riders.must_be_instance_of Array
    end

    it "each item is of class Rider" do
      all_riders.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "number of riders matches number of lines in CSV - 1 for headder line" do
      csv_length = riders_csv.length
      all_riders.length.must_equal(csv_length - 1)
    end

    it "id of first & last match id of first & last in CSV" do
      all_riders[0].id.must_equal(riders_csv[1][0].to_i)
      all_riders[-1].id.must_equal(riders_csv[-1][0].to_i)
    end
  end

  describe "find_rider Rider class method" do
    it "should return one rider based on numeric ID" do
      this_rider = RideShare::Rider.find_rider(1)
      this_rider.must_be_instance_of RideShare::Rider
    end

    it "should return 0 if no driver found by that ID" do
      bad_id = RideShare::Rider.find_rider("apple")
      bad_id.must_equal 0
    end

  end

end

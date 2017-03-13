require_relative 'spec_helper'

describe "Rider" do
  describe "constructor" do
    before do
      @name = 'Ada'
      @id = 108
      @phone_num = '123.456.7890'
    end

    let (:rider) {RideShare::Rider.new(name: @name, id: @id, phone_num: @phone_num)}

    it "can be instantiated" do
      rider.must_be_instance_of RideShare::Rider
    end

    it "takes a name, phone number, and ID" do
      rider.must_respond_to :name
      rider.name.must_equal @name

      rider.must_respond_to :id
      rider.id.must_equal @id

      rider.must_respond_to :phone_num
      rider.phone_num.must_equal @phone_num
    end
  end

  # As this method simply calls the Trip.find_all_for_rider method,
  # extensive testing was not done.
  describe "trips" do
    it "returns only Trips that match this rider's id" do
      rider_77 = RideShare::Rider.new(id: 77)
      rider_77.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
        trip.rider_id.must_equal rider_77.id
      end
    end

    it "returns an empty array if rider id is undefined" do
      rider = RideShare::Rider.new(name: 'Ada')
      rider.trips.must_be_empty
    end
  end

  describe "drivers" do
    let (:drivers_for_rider_54) {RideShare::Rider.new(id: 54).drivers}
    # driver_ids for every trip of rider_54 = [1, 39]

    let (:drivers_for_rider_41) {RideShare::Rider.new(id: 41).drivers}
    # driver_ids for every trip of rider 41 -> [94, 94, 91]

    it "returns an array" do
      drivers_for_rider_54.must_be_instance_of Array
    end

    it "returns only Driver objects in the array" do
      drivers_for_rider_54.each { |driver| driver.must_be_kind_of RideShare::Driver }
    end

    it "returns the correct number of Drivers" do
      drivers_for_rider_54.length.must_equal 2
    end

    it "finds the first driver id listed for that rider in the csv file" do
      first_driver = drivers_for_rider_54.first
      first_driver.id.must_equal 1
    end

    it "find the last driver id listed for that rider in the csv file" do
      last_driver = drivers_for_rider_54.last
      last_driver.id.must_equal 39
    end

    it "returns an empty array if the rider has not taken any trips" do
      # Rider 116 has no trips
      RideShare::Rider.new(id: 116).drivers.must_be_empty
    end

    it "removes any driver duplicates from the returned array" do
      # drivers should only return [94, 91]
      drivers_for_rider_41.length.must_equal 2
    end

    it "lists the drivers from lowest to highest driver id" do
      drivers_for_rider_41.first.id.must_equal 91
      drivers_for_rider_41.last.id.must_equal 94
    end
  end

  describe "Rider.all" do
    let (:riders) {RideShare::Rider.all}
    let (:rider_csv_info) {CSV.read("support/riders.csv")[1 .. -1]} # ignore headers

    it "returns an array" do
      riders.must_be_instance_of Array
    end

    it "returns only Rider instances in the array" do
      riders.each { |rider| rider.must_be_instance_of RideShare::Rider }
    end

    it "returns the correct number of riders" do
      expected_num_of_riders = rider_csv_info.size
      num_of_riders = riders.size
      num_of_riders.must_equal expected_num_of_riders
    end

    it "initializes a 1st Rider with the CSV's first id, name, and phone number" do
      first_rider_id = rider_csv_info.first[0].to_i
      first_rider_name = rider_csv_info.first[1]
      first_rider_phone_num = rider_csv_info.first[2]

      riders.first.id.must_equal first_rider_id
      riders.first.name.must_equal first_rider_name
      riders.first.phone_num.must_equal first_rider_phone_num
    end

    it "initializes a last Rider with the CSV's last id, name, and phone number" do
      last_rider_id = rider_csv_info.last[0].to_i
      last_rider_name = rider_csv_info.last[1]
      last_rider_phone_num = rider_csv_info.last[2]

      riders.last.id.must_equal last_rider_id
      riders.last.name.must_equal last_rider_name
      riders.last.phone_num.must_equal last_rider_phone_num
    end
  end

  describe "Rider.find" do
    let (:rider_csv_info) {CSV.read("support/riders.csv")[1 .. -1]} # ignore headers

    it "returns a Rider that exists" do
      third_rider_id = rider_csv_info[2][0].to_i
      find_and_verify_rider(third_rider_id)
    end

    it "can find the first Rider from the CSV file" do
      first_rider_id = rider_csv_info.first[0].to_i
      find_and_verify_rider(first_rider_id)
    end

    it "can find the last Rider from the CSV file" do
      last_rider_id = rider_csv_info.last[0].to_i
      find_and_verify_rider(last_rider_id)
    end

    it "returns nil if no rider_id is found" do
      fake_rider_id = 308
      RideShare::Rider.find(fake_rider_id).must_be_nil
    end

    private

    def find_and_verify_rider(rider_id)
      rider = RideShare::Rider.find(rider_id)
      rider.must_be_instance_of RideShare::Rider
      rider.id.must_equal rider_id
    end
  end
end

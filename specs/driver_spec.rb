require_relative 'spec_helper'

describe "Driver" do
  describe "constructor" do
    before do
      @name = 'Ada'
      @id = 108
      @vin = '123456789abcdefeg'
    end

    it "can be instantiated" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)
      driver.must_be_instance_of RideShare::Driver
    end

    it "takes a name, VIN, and ID" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)

      driver.must_respond_to :name
      driver.name.must_equal @name

      driver.must_respond_to :id
      driver.id.must_equal @id

      driver.must_respond_to :vin
      driver.vin.must_equal @vin
    end

    it "raises an error if the VIN is not 17 characters long" do
      invalid_vin = '123456dfsd'

      proc {
        RideShare::Driver.new(name: @name, id: @id, vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end

    it "raises an error if the VIN has a character other than a letter or number" do
      invalid_vin = '12345!!#2345ddegd'

      proc {
        RideShare::Driver.new(name: @name, id: @id, vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end
  end

  # describe "trips" do
  #   it "returns an array" do
  #     skip
  #   end
  #
  #   it "returns an array with only Trip objects" do
  #     skip
  #   end
  #
  #   it "returns Trips that only THIS driver has taken" do
  #     skip
  #   end
  # end
  #
  # describe "avg_rating" do
  #   it "returns a float to 1 decimal point" do
  #     skip
  #   end
  #
  #   it "returns the overall avg_rating for a driver" do
  #     #test decimal point
  #     skip
  #   end
  # end

  describe "Driver.all" do
    let (:drivers) {RideShare::Driver.all}
    let (:driver_csv_info) {CSV.read("support/drivers.csv")[1 .. -1]} # ignore headers

    it "returns an array" do
      drivers.must_be_instance_of Array
    end

    it "contains only Driver elements in the returned array" do
      drivers.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "returns the correct number of drivers" do
      expected_num_of_drivers = driver_csv_info.size
      num_of_drivers = drivers.length

      num_of_drivers.must_equal expected_num_of_drivers
    end

    it "initializes a first Driver with the CSV's first listed id, name, and vin" do
      first_driver_id = driver_csv_info.first[0].to_i
      first_driver_name = driver_csv_info.first[1]
      first_driver_vin = driver_csv_info.first[2]

      drivers.first.id.must_equal first_driver_id
      drivers.first.name.must_equal first_driver_name
      drivers.first.vin.must_equal first_driver_vin
    end

    it "initializes a last Driver with the CSV's last listed name, id, and vin" do
      last_driver_id = driver_csv_info.last[0].to_i
      last_driver_name = driver_csv_info.last[1]
      last_driver_vin = driver_csv_info.last[2]

      drivers.last.id.must_equal last_driver_id
      drivers.last.name.must_equal last_driver_name
      drivers.last.vin.must_equal last_driver_vin
    end
  end

  describe "Driver.find" do
    let (:driver_csv_info) {CSV.read("support/drivers.csv")[1 .. -1]} # ignore headers

    it "returns a Driver that exists" do
      third_driver_id = driver_csv_info[2][0].to_i
      find_and_verify_driver(third_driver_id)
    end

    it "can find the first Driver from the CSV file" do
      first_driver_id = driver_csv_info.first[0].to_i
      find_and_verify_driver(first_driver_id)
    end

    it "can find the last Driver from the CSV file" do
      last_driver_id = driver_csv_info.last[0].to_i
      find_and_verify_driver(last_driver_id)
    end

    it "returns nil if no driver_id is found" do
      fake_driver_id = 108
      RideShare::Driver.find(fake_driver_id).must_be_nil
    end

    private

    def find_and_verify_driver(driver_id)
      driver = RideShare::Driver.find(driver_id)
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal driver_id
    end
  end
end

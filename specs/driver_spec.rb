require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver class" do
  let (:driver_hash) { { id: 6, name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWU" } }
  let (:driver)  { RideShare::Driver.new(driver_hash) }

  describe "#initialize method" do
    it "Initializes a new driver instance from the parameter" do
      driver.must_be_instance_of RideShare::Driver
      driver.must_respond_to :id
      driver.id.must_equal driver_hash[:id]
      driver.must_respond_to :name
      driver.name.must_equal driver_hash[:name]
      driver.must_respond_to :vin
      driver.vin.must_equal driver_hash[:vin]
    end

    it "Raises an argument error if the vin number is invalid: must have length 17" do
      proc {
        RideShare::Driver.new({ id: 6, name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWUXXX" })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the driver_hash parameter is incomplete" do
      proc {
        RideShare::Driver.new({})
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new({ name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWU" })
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new({ nick_name: "Betsy", vin: "L1CXMYNZ3MMGTTYWU" })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the parameter is not hash" do
      proc {
        RideShare::Driver.new()
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new("6, Mr. Hyman Wolf, L1CXMYNZ3MMGTTYWU")
      }.must_raise ArgumentError
    end
  end

  xdescribe "#trips method" do
    it "Retrieve the list of trip instances that only this driver has taken" do
      trips_by_driver = driver.trips
      trips_by_driver.must_equal Array
      trips_by_driver.length.must_equal 3
      trips_by_driver.must_equal [
        RideShare::Trip.new(
        {
          id: 162,
          driver_id: 6,
          rider_id: 93,
          date: "2015-03-09",
          rating: 4
          }
        ),
        RideShare::Trip.new(
        {
          id: 169,
          driver_id: 6,
          rider_id:	204,
          date:	"2015-05-19",
          rating:	4
        }
        ),
        RideShare::Trip.new(
        {
          id: 295,
          driver_id: 6,
          rider_id: 87,
          date: "2015-08-14",
          rating: 1
        }
        )
      ]
    end
  end
  #
  # describe "#avg_rating method" do
  #   it "Retrieve an average rating for that driver based on all trips taken" do
  #
  #   end
  #
  # end
  #
  # describe "#self.all method" do
  #   it "Retrieve all drivers from the CSV file" do
  #
  #   end
  # end
  #
  # describe "#self.find method" do
  #   it "Find a specific driver using their numeric ID" do
  #
  #   end
  # end
end

# new Driver, subclass of RideShare
module RideShare
  class Driver
    attr_reader :id, :name, :vin
    # create new driver and take in id, name, vin
    def initialize(driver_info) # ={}
      @id = driver_info[:id]
      @name = driver_info[:name]
      @vin = driver_info[:vin]
    end
  end
end
# instance method: trips
# return collection of trip instances by this driver

# instance method: avg-rating
# return rounded average rating across all trips by this driver

# class method: all
# read in CSV file for all instances of drivers
# return all instances of driver

# class method: find(id)
# return specific instance of driver (previously instantiated)

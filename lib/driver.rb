require 'csv'

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

    # instance method: trips
    # return collection of trip instances by this driver

    # instance method: avg-rating
    # return rounded average rating across all trips by this driver

    # class method: all
    def self.all
      @all_drivers = []
      # read in CSV file for all instances of drivers
      CSV.foreach("support/drivers.csv", {:headers => true}) do |row| # file directory for rake
        @all_drivers << RideShare::Driver.new({
          id: row[0],
          name: row[1],
          vin: row[2]
        })
      end
      return @all_drivers
      # return all instances of driver
    end

    # class method: find(id)
    def self.find(driver_id)
      # return specific instance of driver (previously instantiated)
      found_driver = @all_drivers.select { |instance| instance.id == driver_id }
      return found_driver[0]
    end
  end
end

require 'csv'

# new Driver, subclass of RideShare
module RideShare
  class Driver
    attr_reader :id, :name, :vin
    # create new driver and take in id, name, vin
    def initialize(driver_info={})
      @id = driver_info[:id]
      @name = driver_info[:name]
      unless (driver_info[:vin] == nil || driver_info[:vin].length == 17)
        raise ArgumentError.new("vin is invalid")
      end
      @vin = driver_info[:vin]
    end

    def trips
    RideShare::Trip.by_driver(@id)
    # return collection of trip instances by this driver
    end

    def avg_rating
      ratings = trips.map {|trip| trip.rating.to_i }
      average = ratings.inject(:+)/ratings.length
      return average.round(2)
      # return rounded average rating across all trips by this driver
    end

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

    def self.find(driver_id)
      found_driver = @all_drivers.select { |instance| instance.id == driver_id }
      return found_driver[0]
      # return specific instance of driver (previously instantiated)
    end
  end
end

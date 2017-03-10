# Driver
#
# Each driver should:
#
# TODO: have an ID, name and vehicle identification number

# TODO: Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number

# Given a driver object, you should be able to:
#
# TODO: retrieve the list of trip instances that only this driver has taken
# TODO: retrieve an average rating for that driver based on all trips taken

# You should be able to:
#
# TODO:retrieve all drivers from the CSV file
# TODO: find a specific driver using their numeric ID

require 'csv'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin
    def initialize (driver_id, name, vin)
      @driver_id = driver_id
      @name = name
      @vin = vin

    end

    def self.all
      # TODO: Clean up variable names.
      read_file = CSV.readlines('support/drivers.csv')

      cleaned_array = read_file.delete_if do |row|
        row == read_file[0]
      end

      drivers_array = []
      cleaned_array.each do |var|
        driver = self.new(var[0].to_s, var[1].to_s, var[2].to_s)

        drivers_array << driver
      end
      return drivers_array
    end

    def self.find(driver_id)
      drivers = RideShare::Driver.all
      counter = 0

      drivers.each do |driver|
        if driver.driver_id == driver_id
          return driver.name
        else
          counter += 1
        end
      end

    end

    def trips
    end

    def avg_rating
    end

  end
end


# test_1 = RideShare::Driver.all
#
# puts test_1.is_a? Array

test_1 = RideShare::Driver.find("50")

puts test_1

# Driver

require_relative 'trip'
require 'csv'

module RideShare
  # DONE: have an ID, name and vehicle identification number
  class Driver
    attr_reader :driver_id, :name, :vin
    def initialize (driver_id, name, vin)
      @driver_id = driver_id
      @name = name
      @vin = vin

    end

    # DONE:retrieve all drivers from the CSV file
    # DONE: Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
    def self.all
      # TODO: Clean up variable names.
      # TODO: Add 'or' statement to delete_if for vins.
      read_file = CSV.readlines('support/drivers.csv')

      cleaned_array = read_file.delete_if do |row|
        row == read_file[0]
      end

      drivers_array = []
      cleaned_array.each do |params|
        if params[2].to_s.length == 17
          driver = self.new(params[0].to_s, params[1].to_s, params[2].to_s)
          drivers_array << driver
        end
      end
      return drivers_array
    end

    # DONE: find a specific driver using their numeric ID
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

    # DONE: retrieve the list of trip instances that only this driver has taken
    def trips(driver_id)
      new_instance = RideShare::Trip.new("", "", "", "", "")
      trips = new_instance.find_all_driver_instances(driver_id)
      # print trips
      # puts "Working"


      # new_instance = RideShare::Trip.new("", "", "", "", "")
      # trips = new_instance.find_all_driver_instances(driver_id)
      # puts trips
      # puts "Working"
      # new_instance = RideShare::Trip::find_all_driver_instances("1")
    end

    # DONE: retrieve an average rating for that driver based on all trips taken
    def avg_rating(driver_id)
      rating_sum = 0
      trips_array = trips(driver_id)

      trips_array.each do |instance|
        # FIXME: Can't call rating, produces error
        rating_sum += instance[4].to_i
      end
      if trips_array.length == 0
        # TODO: Argument Error
      else
        avg_rating = rating_sum / (trips_array.length)
        return avg_rating
      end
    end

  end
end

#### Note: did not pass any vars through trips.
# new_instance = RideShare::Trip.new("1", "", "", "", "")
# trips = new_instance.find_all_driver_instances(driver_id)
# # puts trips
# # puts "Working"
####





# test_1 = RideShare::Driver.all
#
# print test_1#.is_a? Array

# test_1 = RideShare::Driver.find("1")
#
# puts test_1

# test_1 = RideShare::Driver.new("", "", "")
#
# print test_1.trips("13")
#
# test_1 = RideShare::Driver.new("", "", "")
#
# puts test_1.avg_rating("13")

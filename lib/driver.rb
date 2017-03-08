require 'csv'
#require_relative 'trip'

module Ride_share_two
  class Driver
    attr_reader :driver_id, :driver_name, :vin, :drivers
    def initialize(driver_id, driver_name, vin)
      raise ArgumentError.new("vin.length must be == 17") if vin.length != 17
      @driver_id = driver_id
      @driver_name = driver_name
      @vin = vin
      @drivers = []
    end
    #retrieve all drivers from the CSV file
    def self.all_drivers
      @drivers = []
      CSV.read("./support/drivers.csv").drop(1).each do |line|
        @drivers << self.new(line[0].to_s,line[1].to_s,line[2].to_s)
      end
      return @drivers
    end


    #find a specific driver using their numeric ID
    def self.find_driver(id)
      self.all_drivers.each do |driver|
        if driver.driver_id == id.to_s
          return driver.driver_name
        end
      end
    end

    def find_trips_for_driver
      #Ride_share_two::Trip.find_trips_for_driver(driver_id)
      trips_for_driver =[]
      Ride_share_two::Trip.all_trips.each do |trip|
        if trip.driver_id == driver_id
          trips_for_driver <<  trip
        end
      end
      return trips_for_driver
    end

    def average_driver_rating#(driver_id) don't need an argument
      total = 0
      find_trips_for_driver.each do |trip|
        total += trip.rating
      end
      return total / find_trips_for_driver.length
    end

  end
end

# driver1 = Ride_share_two::Driver.new("1", "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
# p driver1.find_trips_for_driver.length
#puts Ride_share_two::Driver.all_drivers[2]
# puts Ride_share_two::Driver.driver[1].vin
#puts Ride_share_two::Driver.
# p Ride_share_two::Driver.new("1", "Bernardo Prosacco", "aaaaa")
# driver1 = Ride_share_two::Driver.new("1", "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
# p Ride_share_two::Driver.all_drivers[0].driver_id

#retrieve the list of trip instances that only this driver has taken
# def find_trip (driver_id)
#   TODO: add a storage variable
#   call the collection from the trip class
#   each loop
#     find driver(id)
#     compare it with input(param) - conditional
#     if driver_id matches
#       store trip_id
#     end
#   end
#   return storage_variable
#
# end

#retrieve an average rating for that driver based on all trips taken
# def average_driver_ranting(driver_id)
#   TODO: add a storage_variable
#   get trips data by driver id
#   take rating
#   add to storage
# end
# return storage_variable/collection.length

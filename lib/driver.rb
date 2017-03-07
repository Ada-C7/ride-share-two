require 'csv'

module Ride_share_two
  class Driver
    attr_reader :driver_id, :driver_name, :vin, :drivers
    def initialize(driver_id, driver_name, vin)
      # raise ArgumentError.new("vin.length must be == 17") if vin.length != 17
      @driver_id = driver_id
      @driver_name = driver_name
      @vin = vin
      @drivers = []
    end

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
    #retrieve all drivers from the CSV file
    #find a specific driver using their numeric ID

    def self.driver
      @drivers = []
      CSV.read("../support/drivers.csv").each do |line|
        @drivers << self.new(line[0].to_s,line[1].to_s,line[2].to_s)
      end
      return @drivers
    end

    def self.find(id)
      self.driver.each do |driver|
        #p driver.driver_id
        if driver.driver_id == id.to_s
          return driver.driver_name
        end
      end
    end

  end
end


driver1 = Ride_share_two::Driver.new("driver_id", "driver_name", "vin")
puts Ride_share_two::Driver.driver[1].driver_id
puts Ride_share_two::Driver.driver[1].driver_name
puts Ride_share_two::Driver.driver[1].vin
#puts Ride_share_two::Driver.find(1)

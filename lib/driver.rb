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
    def initialize (driver_id, name, vin)
      @driver_id = driver_id
      @name = name
      @vin = vin
      @drivers_array = []
    end

    def self.all
      read_file = CSV.read('support/drivers.csv')


      read_file.map do |line|
        @driver_id = line[0].to_i
        @name = line[1].to_s
        @vin = line[2].to_s
        new_driver = RideShare::Driver.new(@driver_id, @name, @vin)
        drivers_array << new_driver
      end
      puts "#{drivers_array}"
    end
  end
end




# test_1 = RideShare::Driver.new(213124, "jake", "jkdfr435")
#
# puts test_1

require 'csv'
require 'pry'

module RideShare
    class Driver
        DRIVER_INFO = CSV.read('support/drivers.csv')

        attr_accessor :driver_id, :name, :vin

        def initialize(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id > 0
            DRIVER_INFO.each do |line|
                next unless line[0].to_i == id
                @driver_id = id
                @name = line[1]
                @vin = line[2]
            end
            raise ArgumentError, "#{vin} is an invalid VIN number" unless @vin.length == 17
        end

        def trips
            Trip.driver_trips(@driver_id)
        end

        def avg_rating
            @driver_trips = trips
            avg_rating = (@driver_trips.map { |trip| trip.trip_rating.to_f }).reduce(:+) / @driver_trips.length
        end

        def self.all
            @all_drivers = DRIVER_INFO.drop(1).map { |line| Driver.new(line[0].to_i) }
        end

        def self.find(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id > 0
            all
            driver_found = (@all_drivers.map { |driver| driver if driver.driver_id == id }).compact!
        end
    end
end

print RideShare::Driver.find(89)
#
# test = RideShare::Driver.new(18)
# #
# print test.trips
# puts
# print test.trips
# puts
# puts test.avg_rating
# puts test.avg_rating
# print test.trips

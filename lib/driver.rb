require 'csv'
# require_relative 'trip'

module RideShare
    class Driver
        DRIVER_INFO = CSV.read('support/drivers.csv')

        attr_reader :driver_id, :name, :vin

        def initialize(id)
            raise ArgumentError, '#{id} is not a valid ID number' unless (1..100).cover? id
            DRIVER_INFO.each do |line|
                next unless line[0].to_i == id
                @driver_id = id
                @name = line[1]
                @vin = line[2]
            end
        end

        def trips
            Trip.driver_trips(@driver_id)
        end

        def avg_rating
            all_ratings = []
            @driver_trips = trips
            @driver_trips.each do |trip|
                all_ratings << trip.last.to_i
            end

            avg_rating = all_ratings.reduce(:+) / all_ratings.length.to_f
            avg_rating
        end

        def self.all
            DRIVER_INFO[1..100]
        end

        def self.find(id)
            @driver_found = (DRIVER_INFO.map { |line| line if line[0] == id.to_s }).compact!
        end
    end
end

# print RideShare::Driver.find(89)
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

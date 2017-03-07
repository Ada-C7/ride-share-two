require 'csv'
require_relative 'driver'

module RideShare
    class Trip
        TRIP_INFO = CSV.open('support/trips.csv')

        def initialize(id)
            TRIP_INFO.each do |line|
                next unless line[0].to_i == id
                @trip_id = id
                @driver_id = line[1]
                @rider_id = line[2]
                @trip_date = line[3]
                @trip_rating = line[4]
            end
        end

        def driver
            @driver_info = RideShare::Driver.find(@driver_id)
        end

        def rider
            @rider_info = RideShare::Driver.find(@rider_id)
        end

        def self.all
            TRIP_INFO
        end

        def self.driver_trips(id)
            @driver_trips = []
            TRIP_INFO.each do |line|
                next unless line[1] == id
                @driver_trips << line
            end
            @driver_trips
        end

        def self.rider_trips(id)
            @rider_trips = []
            TRIP_INFO.each do |line|
                next unless line[2] == id
                @rider_trips << line
            end
            @driver_trips
        end
    end
end

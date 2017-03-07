require 'csv'
# require_relative 'driver'
# require_relative 'rider'

module RideShare
    class Trip
        TRIP_INFO = CSV.read('support/trips.csv')

        attr_reader :trip_id, :driver_id, :rider_id, :trip_date, :trip_rating

        def initialize(id)
            raise ArgumentError, '#{id} is not a valid ID number' unless (1..600).cover? id
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
            Driver.find(@driver_id)
        end

        def rider
            Rider.find(@rider_id)
        end

        def self.all
            TRIP_INFO[1..600]
        end

        def self.driver_trips(id)
            @driver_trips = (TRIP_INFO.map { |line| line if line[1].to_i == id }).compact!
        end

        def self.rider_trips(id)
            @rider_trips = (TRIP_INFO.map { |line| line if line[2].to_i == id }).compact!
        end
    end
end

# trip = RideShare::Trip.new(30)
#
# print trip.driver

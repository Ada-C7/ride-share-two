require 'csv'

module RideShare
    class Trip
        TRIP_INFO = CSV.read('support/trips.csv')

        attr_reader :trip_id, :driver_id, :rider_id, :trip_date, :trip_rating

        def initialize(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id > 0
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
            Driver.find(@driver_id.to_i)
        end

        def rider
            Rider.find(@rider_id.to_i)
        end

        def self.all
            @all_trips = TRIP_INFO.drop(1).map { |line| Trip.new(line[0].to_i) }
        end

        def self.driver_trips(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id > 0
            all
            @driver_trips = (@all_trips.map { |trip| trip if trip.driver_id.to_i == id }).compact!
        end

        def self.rider_trips(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id > 0
            all
            @rider_trips = (@all_trips.map { |trip| trip if trip.rider_id.to_i == id }).compact!
        end
    end
end

# print RideShare::Trip.rider_trips(5)
# puts
# puts
# print RideShare::Trip.driver_trips(12)
# puts
# puts
# print RideShare::Trip.rider_trips(76)

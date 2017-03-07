require 'csv'

module RideShare
    class Trip
        TRIP_INFO = CSV.read('support/trips.csv')

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
            @driver_trips = (TRIP_INFO.map { |line| line if line[1].to_i == id }).compact!
        end

        def self.rider_trips(id)
            @rider_trips = (TRIP_INFO.map { |line| line if line[2].to_i == id }).compact!
        end
    end
end

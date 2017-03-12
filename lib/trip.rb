require 'csv'

module RideShare
    class Trip
        TRIP_INFO = CSV.read('support/trips.csv')

        attr_reader :trip_id, :driver_id, :rider_id, :trip_date, :trip_rating

        def initialize(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id >= 1
            raise ArgumentError, "#{id} Cannot be found" unless (TRIP_INFO.map { |line| line[0].to_i }).include? id
            TRIP_INFO.each do |line|
                next unless line[0].to_i == id
                @trip_id = id
                @driver_id = line[1]
                @rider_id = line[2]
                @trip_date = line[3]
                @trip_rating = line[4]
            end

            raise ArgumentError, "#{trip_rating} is an invalid rating number" unless (1..5).cover? @trip_rating.to_f
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
            if @driver_trips == []
                puts 'This driver has no trips'
            else
                @driver_trips
            end
        end

        def self.rider_trips(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id > 0
            all
            @rider_trips = (@all_trips.map { |trip| trip if trip.rider_id.to_i == id }).compact!
            if @rider_trips == []
                puts 'This rider has no trips'
            else
                @rider_trips
            end
        end
    end
end

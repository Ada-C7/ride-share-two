require 'csv'

module RideShare
    class Rider
        RIDER_INFO = CSV.read('support/riders.csv')

        attr_reader :rider_id, :name, :phone_number

        def initialize(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id >= 1
            raise ArgumentError, "#{id} Cannot be found" unless (RIDER_INFO.map { |line| line[0].to_i }).include? id
            RIDER_INFO.each do |line|
                next unless line[0].to_i == id
                @rider_id = id
                @name = line[1]
                @phone_number = line[2]
            end
        end

        def trips
            Trip.rider_trips(@rider_id)
        end

        def previous_drivers
            @rider_trips = trips
            @all_drivers = @rider_trips.map { |trip| trip.driver.shift }
          end

        def self.all
            @all_riders = RIDER_INFO.drop(1).map { |line| Rider.new(line[0].to_i) }
        end

        def self.find(id)
            raise ArgumentError, "#{id} is not a valid ID number" unless id.is_a?(Integer) && id > 0
            all
            @rider_found = (@all_riders.map { |rider| rider if rider.rider_id == id }).compact!
        end
        end
end

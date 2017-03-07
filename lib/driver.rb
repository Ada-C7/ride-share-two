require 'csv'
require_relative 'trip'

module RideShare
    class Driver
        attr_reader :driver_id, :name, :vin

        DRIVER_INFO = CSV.open('../support/drivers.csv')

        def initialize(id)
            DRIVER_INFO.each do |line|
                next unless line[0].to_i == id
                @driver_id = id
                @name = line[1]
                @vin = line[2]
            end
      end

        def trips
            @driver_trips = RideShare::Trip.driver_trips(@driver_id)
        end

        def avg_rating
            @all_ratings = []
            trips
            @driver_trips.each do |trip|
                @all_ratings << trip.last.to_i
            end

            @total_ratings = @all_ratings.reduce(:+)
            @avg_rating =  @total_ratings / @all_ratings.length
            @avg_rating
        end

        def self.all
            DRIVER_INFO
        end

        def self.find(id)
            @driver_found = []
            DRIVER_INFO.each do |line|
                next unless line[0].to_i == id
                @driver_found << line
            end
            @driver_found
          end
  end
end

test = RideShare::Driver.new(18)

test.avg_rating

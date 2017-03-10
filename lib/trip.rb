require 'csv'
#require_relative 'rider'
#require_relative 'driver'

module RideShare
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_hash)

      raise ArgumentError.new "Rating is not between 1-5 for this trip" if trip_hash[:rating] < 1 || trip_hash[:rating] > 5

      @trip_id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
    end

    def self.all
      trips = []

      CSV.read("support/trips.csv", {:headers => true, :header_converters => :symbol, :converters => :all}).each do |line|
        trips << RideShare::Trip.new(line)
      end
      return trips
    end

    def self.find_many_drivers(driver_id)
      #makes a list of trips based on driver_id
      driver_trips = []
      find_trips = RideShare::Trip.all
      find_trips.each do |trips|
        if trips.driver_id == driver_id
          driver_trips << trips
        end
      end

      raise ArgumentError.new "Warning: Rider #{driver_id} does not exist" if driver_trips.empty?

      return driver_trips
    end

    def self.find_many_riders(rider_id)
      #make a list of trips based on a rider-id
      rider_trips = []
      find_trips = RideShare::Trip.all
      find_trips.each do |trips|
        if trips.rider_id == rider_id
          rider_trips << trips
        end
      end

      raise ArgumentError.new "Warning: Rider #{rider_id} does not exist" if rider_trips.empty?

      return rider_trips
    end

    def driver
      # Given a trip instance, you can find the correct driver info from the Driver class
      RideShare::Driver.find(@driver_id)
    end

    def rider
      # Given a trip instance, you can find the correct rider info from the Rider class
      RideShare::Rider.find(@rider_id)
    end

  end
end

puts "#{RideShare::Trip.find_many_drivers(30)}"
# puts "#{RideShare::Trip.find_many_drivers(1337)}"
#puts "#{RideShare::Trip.find_many_riders(5).length}"

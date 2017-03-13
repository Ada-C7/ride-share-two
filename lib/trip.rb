require 'csv'
require_relative 'errors'

module RideShare
  class Trip
    attr_accessor :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(args)
      @trip_id = args[:trip_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]

      # Verify that parameters are appropriate data types
      unless @trip_id.class == Integer && @driver_id.class == Integer && @rider_id.class == Integer && @rating.class == Integer
        raise ArgumentError.new("input must be an integer")
      end

      raise ArgumentError.new("inappropriate rating: rating must be between 1-5") unless @rating >= 1 && @rating <= 5
    end

    # Read from trip csv file and store information as an array of instances
    def self.all
      trips = []
      CSV.foreach("support/trips.csv", {:headers => true, header_converters: :symbol, converters: :all}) do |line|
        trips << RideShare::Trip.new(line)
      end
      return trips
    end

    # Find trip(s) for a particular driver
    # Raise Argument Error if that driver is not valid
    def self.find_for_driver(id)
      trips = []

      all.each do |trip|
        if trip.driver_id == id
          trips << trip
        end
      end

      raise InvalidDriver.new("that driver does not exist") if trips.empty?
      return trips
    end

    # Find trips(s) for a particular rider
    # Raise ArgumentError if that rider is not valid
    def self.find_for_rider(id)
      trips = []

      all.each do |trip|
        if trip.rider_id == id
          trips << trip
        end
      end

      raise InvalidRider.new("that rider does not exist") if trips.empty?
      return trips
    end

    # Find a Driver instance associated with a trip
    def driver
      Driver.find(@driver_id)
    end

    # Find a Rider instance associated with a trip
    def rider
      Rider.find(@rider_id)
    end

  end
end

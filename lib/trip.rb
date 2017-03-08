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

      unless @trip_id.class == Integer && @driver_id.class == Integer && @rider_id.class == Integer && @rating.class == Integer
        raise ArgumentError.new("input must be an integer")
      end

      raise ArgumentError.new("inappropriate rating: rating must be between 1-5") unless @rating >= 1 && @rating <= 5
    end

    def self.all
      trips = []
      CSV.foreach("support/trips.csv", {:headers => true, header_converters: :symbol, converters: :all}) do |line|
        trips << RideShare::Trip.new(line)
      end
      return trips
    end

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

  end
end

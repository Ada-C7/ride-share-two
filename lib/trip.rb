require 'csv'
require 'date'

module RideShare
  class Trip
    attr_reader :id, :rider_id, :driver_id, :date, :rating

    def initialize(params)
      @id = params[:id]
      @rider_id = params[:rider_id]
      @driver_id = params[:driver_id]
      @date = params[:date]
      @rating = params[:rating]

      validate_params(params)
    end

    def self.all
      @@all ||= CSV.read("support/trips.csv", headers:true).map do |line|
        RideShare::Trip.new(
          id: Integer(line[0]),
          driver_id: Integer(line[1]),
          rider_id: Integer(line[2]),
          date: Date.parse(line[3]),
          rating: Integer(line[4])
        )
      end
    end

    def self.find(target_id)
      all.find { |trip| trip.id == target_id }
    end

    def self.by_driver(target_driver_id)
      all.select { |trip| trip.driver_id == target_driver_id }
    end

    def self.by_rider(target_rider_id)
      all.select { |trip| trip.rider_id == target_rider_id }
    end

    def driver
      Driver.find(@driver_id)
    end

    def rider
      Rider.find(@rider_id)
    end

    private

    def validate_params(params)
      if [@id, @rider_id, @driver_id, @date, @rating].include? nil
        raise ArgumentError.new("Drivers must have an ID, rider ID, driver ID, date, and rating.")
      elsif !@rating.between?(1,5)
        raise ArgumentError.new("Rating must be between 1 and 5.")
      end
    end

  end
end

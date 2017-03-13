require 'csv'

# require_relative 'trip'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    def initialize(driver_info)
      # have an ID, name and vehicle identification number
      @driver_id = driver_info[:driver_id]
      @name = driver_info[:name]

      # Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
      raise ArgumentError.new("A valid vin is 17 characters long") if driver_info[:vin].length < 17

      @vin = driver_info[:vin]
    end

    def self.create_all_drivers
      # retrieve all drivers from the CSV file
      CSV.read(
      "support/drivers.csv",
      headers: true,
      header_converters: :symbol,
      converters: :all
      ).map { |line| line.to_h }
    end

    def self.find(driver_id)
      # find a specific driver using their numeric ID
      id_find = self.create_all_drivers
      id_find.each do |i|
        if i[:driver_id] == driver_id
          return i
        end
      end
    end

    def trips
      @all_trips = RideShare::Trip.driver_trips(@driver_id)
      return @all_trips
    end

    def trip_average
      trips
      trip_ratings = @all_trips.map { |each_trip| each_trip[:rating] }
      raise ArgumentError.new("This driver has no ratings at this time") if trip_ratings.length == 0
      trip_ratings.inject(0, :+)/trip_ratings.length
    end


  end
end

require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name, :trips

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @vin = params[:vin]
      @trips = params[:trips]
      @trips ||= []

      validate_params(params)
    end

    def self.all
      @@all ||= CSV.read("support/drivers.csv", headers:true).map do |line|
        Driver.new(
          id: Integer(line[0]),
          name: line[1],
          vin: line[2]
        )
      end
    end

    def self.find(target_id)
      all.find { |driver| driver.id == target_id }
    end

    def import_trips
      @trips = Trip.by_driver(@id)
    end

    def average_rating
      return nil if trips.empty?
      trips.map { |trip| trip.rating }.reduce(:+).to_f/(trips.length).round(1)
    end

    private
    VIN_LENGTH = 17

    def validate_params(params)
      if [@id, @name, @vin].include? nil
        raise ArgumentError.new("Drivers must have an ID, name, and VIN.")
      elsif @vin.length != VIN_LENGTH
        raise ArgumentError.new("VIN must be #{VIN_LENGTH} characters.")
      end
    end

  end
end

require_relative 'data_import'

module RideShare
  class Driver
    attr_reader :id, :name, :trips
    SOURCE_FILE = "support/drivers.csv"

    def initialize(params)
      validate_params(params)

      @id = params[:id]
      @name = params[:name]
      @vin = params[:vin]
      @trips = params[:trips]
      @trips ||= []
    end

    def self.all
      @@all ||= DataImport.import_attributes(SOURCE_FILE).map do |driver|
        Driver.new(driver)
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
      required_attributes = [:id, :name, :vin]

      missing = required_attributes.select do |attribute|
        !params.keys.include?(attribute) || params[attribute].to_s.empty?
      end

      if !missing.empty?
        raise ArgumentError.new("Missing parameter(s): #{missing.join(", ")}")
      elsif params[:vin].length != VIN_LENGTH
        raise ArgumentError.new("VIN must be #{VIN_LENGTH} characters.")
      end
    end

  end
end

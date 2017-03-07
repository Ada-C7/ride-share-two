require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name

    def initialize(params)
      raise ArgumentError.new("VIN must be 17 characters.") if params[:vin].length != 17

      @id = params[:id]
      @name = params[:name]
      @vin = params[:vin]
    end

    def self.all
      @@all ||= CSV.read("support/drivers.csv", headers:true).map do |line|
        Driver.new(
          id: line[0].to_i,
          name: line[1],
          vin: line[2]
        )
      end
    end

    def self.find(target_id)
      all.find { |driver| driver.id == target_id }
    end

    def trips
      @trips ||= Trip.by_driver(@id)
    end

    def average_rating
      return nil if trips.length == 0
      trips.map { |trip| trip.rating }.reduce(:+).to_f/trips.length.round(1)
    end

  end
end

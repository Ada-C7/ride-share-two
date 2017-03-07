require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name, :trips

    def initialize(params)
      validate_params(params)

      @id = params[:id]
      @name = params[:name]
      @vin = params[:vin]
      @trips = params[:trips]
      @trips ||= []
    end

    def validate_params(params)
      if [params[:id], params[:name], params[:vin]].include? nil
        raise ArgumentError.new("Drivers must have an ID, name, and VIN.")
      elsif params[:vin].length != 17
        raise ArgumentError.new("VIN must be 17 characters.")
      end
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

    def import_trips
      @trips = Trip.by_driver(@id)
    end

    def average_rating
      return nil if trips.empty?
      trips.map { |trip| trip.rating }.reduce(:+).to_f/trips.length.round(1)
    end

  end
end

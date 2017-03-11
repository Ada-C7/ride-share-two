module RideShare
  class Rider < Uber
    attr_reader :id, :name, :trips
    SOURCE_FILE = "support/riders.csv"

    def initialize(params)
      validate_params(params, [:id, :name, :phone_number])

      @id = params[:id]
      @name = params[:name]
      @phone_number = params[:phone_number]
      @trips = params[:trips]
    end

    def self.all
      @@all ||= super(SOURCE_FILE)
    end

    def trips
      @trips ||= Trip.by_rider(@id)
    end

    def drivers
      trips.map { |trip| Driver.find(trip.driver_id) }.uniq
    end

    def cumulative_spending
      trips.map { |trip| trip.fare }.reduce(0, :+).round(2)
    end

  end
end

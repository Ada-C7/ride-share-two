require_relative 'module'

module RideShare
  class Trip < Loadable
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(params)
      @id = params[:trip_id].to_i
      @driver_id = params[:driver_id].to_i
      @rider_id = params[:rider_id].to_i
      @date = params[:date]
      @rating = params[:rating].to_i
      raise ArgumentError.new "The rating must be between 1 and 5" if @rating > 5 || @rating < 0
    end

    def self.all
      super('./support/trips.csv')
    end

    def self.rider_find(id)
      self.all.select { |trip| trip.rider_id == id }
    end

    def self.driver_find(id)
      self.all.select { |trip| trip.driver_id == id}
    end

    def driver_for_trip
      RideShare::Driver.find(@driver_id)
    end

    def rider_for_trip
      RideShare::Rider.find(@rider_id)
    end

  end
end

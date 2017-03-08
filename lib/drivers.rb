require 'csv'
require_relative 'loadable'
require_relative 'trips'

module RideShare
  class Driver < Loadable

    attr_reader :name, :id

    def initialize(params)
      @name = params[:name]
      @id = params[:driver_id].to_i
    end

    def self.all
      super("./support/drivers.csv")
    end

    def all_trips(id)
      driver_trips = RideShare::Trip.driver_find(id)
      raise ArgumentError.new "Sorry, this driver has no trips" if driver_trips.length < 1
      driver_trips
    end

    def average_rating(id)
      (all_trips(id).sum { |trip| trip.rating } / all_trips(id).length.to_f).round(2)
    end
  end
end

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

    def self.find(id)
      account = super(id)
      account = [account.id, account.name]
    end

    def return_all_trips(id)
      driver_trips = RideShare::Trip.all.select { |trip| trip.driver_id == id }
      raise ArgumentError.new "Sorry, this driver has no trips" if driver_trips.length < 1
      driver_trips
    end

    def all_trips(id)
      return_all_trips(id).map do |trip|
         {trip_id: trip.id, date: trip.date, rating: trip.rating}
      end
    end

    def average_rating(id)
      (return_all_trips(id).sum { |trip| trip.rating } / return_all_trips(id).length.to_f).round(2)
    end
  end
end

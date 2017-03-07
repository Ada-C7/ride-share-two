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
      driver_trips = []
      RideShare::Trip.all.map { |trip| driver_trips << trip if trip.driver_id == id }
      driver_trips
    end

    def all_trips(id)
      raise ArgumentError.new "Sorry, this driver has no trips" if return_all_trips(id).length < 1
      all_trips = []
      return_all_trips(id).each do |trip|
        all_trips << {trip_id: trip.id, date: trip.date, rating: trip.rating}
      end
      all_trips
    end

    def average_rating(id)
      average = 0.0
      raise ArgumentError.new "Sorry, this driver has no trips" if return_all_trips(id).length < 1
      return_all_trips(id).each { |trip| average += trip.rating }
      average = (average / return_all_trips(id).length).round(2)
    end
  end
end

ron = RideShare::Driver.new({name: "Ron Weasley", driver_id: 1})

puts ron.all_trips(ron.id)

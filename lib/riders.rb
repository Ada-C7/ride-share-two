require 'csv'
require_relative 'loadable'
require_relative 'trips'

# think about using public vs private methods

module RideShare
  class Rider < Loadable
    attr_reader :id, :name, :phone_num
    def initialize(params)
      @id = params[:rider_id].to_i
      @name = params[:name]
      @phone_num = params[:phone_num]
    end
    
    def self.all
      super("./support/riders.csv")
    end

    def all_trips(id)
      rider_trips = RideShare::Trip.rider_find(id)
      raise ArgumentError.new "Sorry, this rider has no trips" if rider_trips.length < 1
      rider_trips
    end

    def all_drivers(id)
      all_trips(id).map { |trip| trip.driver_id }
    end

  end
end

# initialization_hash = {
#   name: "Ron Weasley",
#   rider_id: 2,
#   phone_num: "2062424564"
# }
# rider = RideShare::Rider.new(initialization_hash)
# puts rider.all_drivers()

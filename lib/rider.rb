require_relative 'rideshare'

module RideShare

  class Rider

    attr_reader :id, :name, :phone

    def initialize
    # each rider must have @ID, @name, and @phone
    end

    def self.all
    # returns array of all instances of rider
    end

    def self.find(rider_id)
    # given rider_ID, returns rider
    end

    def trips
    # given rider ID
    # calls trips.find_riders(rider_ID)
    # returns array of rider's trips
    end

    def drivers
    # calls rider.trips
    # map rider.trips to rider's drivers array
    # returns array of rider's drivers
    end

  end

end

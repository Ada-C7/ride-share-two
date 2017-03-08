require 'csv'


module Rideshare

  class Rider
    attr_reader :rider_id, :name, :phone_num

    def initialize rider_id, name, phone_num
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num

    end
#
    def self.all
      @riders = []

      CSV.open("/Users/adai/Documents/ada/projects/ride-share-two/support/riders.csv", {:headers => true}).each do |line|
        rider = Rideshare::Rider.new(line[0].to_i, line[1], line[2])
        @riders << rider
      end
    end

    def self.all_riders
      return @riders
    end

    def self.find id
      raise ArgumentError.new "Not a valid rider id" if id > 300 || id < 1

      Rideshare::Rider.all_riders.each do |rider|
        if id == rider.rider_id
          return rider
        end
      end
    end

    def trips
      rider_trips = []

      Rideshare::Trips.all_trips.each do |trip|
        if @rider_id == trip.rider_id.to_i
          rider_trips << trip
        end
      end
      return rider_trips
    end

    def drivers # should be an instance method
      #should use the output of trips method, and return driver objects
      #how to call the method on an instance?
      # if the instance variable of @id matches the trip, run method
      drivers = []

      trips.each do |trip|
        drivers << Rideshare::Driver.find(trip.driver_id)
      end

      return drivers

    end
  end
end

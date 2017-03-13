require 'csv'
module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone_num

    def initialize(rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end

    def trips
      Trip.find_many_riders(@rider_id)
    end

    def drivers
      # Currently just returning IDs for drivers. May want to refactor to return names of drivers?
      drivers = []
      rider_trips = Rider.find(@rider_id).trips

      rider_trips.each do |trip|
        drivers << trip.driver_id
      end
      return drivers
    end

    def self.all
      riders = []
      CSV.open("./support/riders.csv", "r").each do |line|
        riders << self.new(line[0].to_s, line[1].to_s, line[2].to_s)
      end
      return riders
    end

    def self.find(id)
      riders = self.all

      riders.each do |rider|
        if rider.rider_id == id
          return rider
        end
      end
      raise ArgumentError.new("Rider not found")
    end
  end
end

require 'csv'

module Ride_share_two
  class Rider
    attr_reader :rider_id, :name, :phone_num
    def initialize(rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end
    # retrieve all riders from the CSV file
    def self.all_riders
      CSV.read("./support/riders.csv").drop(1).map { |line| self.new(line[0].to_s,line[1].to_s,line[2].to_s) }
      #creating new instance
    end

    #find a specific rider using their numeric ID
    def self.find_rider(rider_id)
      self.all_riders.find { |rider| rider.rider_id == rider_id.to_s }
    end
    #retrieve the list of trip instances that only this rider has taken
    def find_trips_for_rider
      Ride_share_two::Trip.all_trips.find_all { |trip| trip.rider_id == rider_id }
    end
    #retrieve the list of all previous driver instances (through the trips functionality built above)
    def find_drivers_by_find_trips_for_rider
      find_trips_for_rider.map { |trip| trip.driver_id }.uniq
    end
    
  end
end

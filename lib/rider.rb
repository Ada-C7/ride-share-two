require_relative 'rideshare'

module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone
    def initialize(rider_id, name, phone)#Instantiated Rider class with ID, name and phone number
      @rider_id = rider_id
      @name = name
      @phone = phone
    end

    def trips
      #Call trips_rider method on class Trip with argument of rider_id to return an array of trips that this rider has completed
    end

    def previous_drivers
      #Collect all trip instances and then loop through each to find driver_id and return a list of previous drivers for the rider
    end

    def self.all
      #Use CSV.read method passing file name as argument to retrieve all riders
    end

    def self.find rider_id
      #check if rider_id is included in the list of riders found in all method above
    end
  end
end

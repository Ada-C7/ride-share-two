require_relative 'rideshare'

module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone
    def initialize(rider_id, name, phone)#Instantiated Rider class with ID, name and phone number
      raise ArgumentError.new("The Rider ID is Invalid") if rider_id.class != Fixnum
      raise ArgumentError.new("The name is Invalid") if name.class != String
      raise ArgumentError.new("The phone number is Invalid") if phone.class != String


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
      CSV.read("support/riders.csv", headers: true).map do | line |
        RideShare::Rider.new(line[0].to_i, line[1], line[2])
      end
    end

    def self.find rider_id
      #check if rider_id is included in the list of riders found in all method above
      self.all.find{ |rider|rider.rider_id == rider_id }
    end
  end
end

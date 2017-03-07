require 'csv'
require_relative 'trip'
require_relative 'driver'
module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      raise ArgumentError.new("Rider id must be an integer") if hash[:rider_id].class != Integer
      if  !(hash[:name][/['. a-zA-Z]+/] == hash[:name])
        raise ArgumentError.new("Name must contain letters only")
      end
      raise ArgumentError.new("Phone must be a string") if hash[:phone].class != String

      @rider_id = hash[:rider_id]
      @name = hash[:name]
      @phone = hash[:phone]
    end

    def all_rider_trips
      RideShare::Trip.all_trips_by_rider(@rider_id)
    end

    def all_rider_drivers #return list of drivers that rider used
      all_rider_drivers = []
      #for each trip that rider has, find driver objects
      # using Driver.find method
      all_rider_trips.each do |trip|
        all_rider_drivers << RideShare::Driver.find(trip.driver_id)
      end
      return all_rider_drivers
    end

    def self.all
      all_riders = []
      csv = CSV.read("support/riders.csv", 'r')
      csv.each do |line|
      #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "rider_id"
        hash = {rider_id: line[0].to_i, name: line[1], phone: line[2]}
        all_riders << Rider.new(hash)
      end
       all_riders
    end

    def self.find(id)
      result = RideShare::Rider.all.select {|rider| rider.rider_id == id}
      if result[0].nil?
        raise ArgumentError.new("Cannot find this ID in riders")
      else
        return result[0]
      end
    end

  end
end

# rider_hash = {rider_id: 32, name: "Natalia", phone:  "1425394958"}
# r = RideShare::Rider.new(rider_hash)
# puts r.name
 #
#  rider = RideShare::Rider.all[25]
# rider.all_rider_drivers.each do  |driver|
#   puts driver.name
#   puts driver.driver_id
# end
 # puts rider.rider_id
 # puts rider.all_rider_trips[0].trip_id
 #
 #
 #



 # puts rider
 # puts "a"
 # puts rider.rider_id
 # puts rider.all_rider_trips

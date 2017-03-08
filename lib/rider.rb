require 'csv'
require_relative 'trip'
require_relative 'driver'
module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone
    def initialize(hash)
      validate_input(hash)
      @rider_id = hash[:rider_id]
      @name = hash[:name]
      @phone = hash[:phone]
    end

    def validate_input(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      if (hash[:rider_id].class != Integer || hash[:rider_id] <= 0)
        raise ArgumentError.new("Rider id must be an positive integer")
      end
      if  !(hash[:name][/['. a-zA-Z]+/] == hash[:name])
        raise ArgumentError.new("Name must contain letters only")
      end
      raise ArgumentError.new("Phone must be a string") if hash[:phone].class != String
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
        next if line[0] == "rider_id"
        hash = {rider_id: line[0].to_i, name: line[1], phone: line[2]}
        all_riders << Rider.new(hash)
      end
       all_riders
    end

    def self.find(id)
      if id.class != Integer || id <= 0
        raise ArgumentError.new("Rider id must be non-negative integer")
      end
      result = RideShare::Rider.all.select {|rider| rider.rider_id == id}
      if result[0].nil?
        raise ArgumentError.new("Cannot find this ID in riders")
      else
        return result[0]
      end
    end

    #optional
    # For a given rider, add the ability
    # to return the total amount of money they have spent on all trips

    def total_amount_spent
      all_rider_trips.each do |trip|
        
      end

    end

  end
end

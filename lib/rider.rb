require 'csv'
require_relative 'trip'
require_relative 'driver'
require 'time'
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

    # Optional
    # For a given rider, add the ability
    # to return the total amount of money they have spent on all trips
    def total_money_spent
      total = 0.0
      all_rider_trips.each do |trip|
        total += trip.cost
      end
      return total
    end
    # For a given rider, add the ability to return the total amount of time
    # they have spent on their trip
    def total_time_spent
      total = Time.new(2017, 01, 02, 0,0,0)
      all_rider_trips.each do |trip|
        total = total.hour * 3600 + total.min * 60
        t1 = Time.parse("2017-01-02 #{trip.duration}")
        total = t1 + total
      end
      puts "Total time spent is #{total.hour}:#{total.min}"
      return "#{total.hour}:#{total.min}"
    end

  end #end of class
end # end of method
#
r = RideShare::Rider.all[73]
puts r.total_time_spent

r = RideShare::Rider.all[73]
puts r.total_money_spent

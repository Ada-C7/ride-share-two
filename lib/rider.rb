require 'csv'
require 'ap'
require_relative 'trip'
require_relative 'driver'

module RideShare
  class Rider
    attr_reader :name, :id, :phone_number
    def initialize(id, name, phone_number)
      @name = name
      @id = id
      @phone_number = phone_number
    end

    def self.all
      @riders = []
      CSV.foreach("./support/riders.csv", {:headers => true}).each do |line|
        @riders << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      return @riders
    end

    def self.find(id)
      rider_find = RideShare::Rider.all
      rider_find.each do |rider|
        if rider.id == id
          return rider
        end
      end
      raise ArgumentError.new "Sorry, a rider with an ID:#{id} does not exist"
    end

    def trip_instances_for_rider
      list_of_riders = RideShare::Trip.find_trips_of_rider(id)
      if list_of_riders.length == 0
        raise ArgumentError.new "Sorry, there is no rider with an ID:#{id}."
      else
        return list_of_riders
      end
    end

    def retrieve_list_of_previous_drivers
      array_of_rider_trips = RideShare::Trip.find_trips_of_rider(id)
      array_of_driver_ids = []
      array_of_rider_trips.each do |item|
        array_of_driver_ids << item.driver_id
      end
      array_of_driver_ids.map do |id|
        RideShare::Driver.find(id)
      end
    end

  end
end

# puts "creates instance for non-self methods\n\n"
# instance_of_rider = RideShare::Rider.find(12)

# puts "retrieve the list of trip instances that only this rider has taken"
# ap instance_of_rider.trip_instances_for_rider

# puts "retrieve all riders from the CSV file"
# ap RideShare::Rider.all

# puts "find a specific rider using their numeric ID"
# ap RideShare::Rider.find(12)

# puts "retrieve the list of all previous driver instances (through the trips functionality built above)"
# ap instance_of_rider.retrieve_list_of_previous_drivers

require 'csv'
require 'pry'

module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone_num

    def initialize(rider_hash)
      raise ArgumentError.new "Rider id must be an integer" if rider_hash[:rider_id].class != Integer
      raise ArgumentError.new "Rider name and phone number must be a string" if rider_hash[:name].class != String || rider_hash[:phone_num].class != String


      @rider_id = rider_hash[:rider_id]
      @name = rider_hash[:name]
      @phone_num = rider_hash[:phone_num]
    end

    def self.all
      riders = []

      CSV.read("support/riders.csv", {:headers => true, :header_converters => :symbol, :converters => :all}).each do |line|
        riders << RideShare::Rider.new(line)
      end

      return riders
    end

    def self.find(rider_id)
      save_rider = nil

      find_riders = RideShare::Rider.all
      find_riders.each do |rider|
        if rider.rider_id == rider_id
          save_rider = rider
        end
      end

      raise ArgumentError.new "Warning: Rider #{rider_id} does not exist." if save_rider == nil

      save_rider
    end

    def rider_trips
      #argument error if rider id given is not in the csv file
      #MAIN GOAL: retrieve the list of trip instances that only this rider has taken
      RideShare::Trip.find_many_riders(@rider_id)
    end

    def drivers
      #argument error if there is a driver that does not exist in the trip instance selected

      #MAIN GOAL:retrieve the list of all previous driver instances (through the trips functionality built above)

      drivers_ids_for_rider_trips = trip.map { |trips| trips.driver_id }

      driver_info = drivers_ids_for_rider_trips.map do |driver_ids|
        RideShare::Trip.find_many_drivers(driver_ids)
      end

      driver_info.uniq
    end

  end
end

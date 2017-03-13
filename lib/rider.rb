#Rider

# Given a rider object, you should be able to:
#
# TODO: retrieve the list of all previous driver instances (through the trips functionality built above)

require_relative 'trip'
require 'csv'

module RideShare

  # DONE: have an ID, name and phone number
  class Rider
    attr_reader :rider_id, :name, :phone_num
    def initialize (rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end

    # DONE: retrieve all riders from the CSV file
    def self.all
      read_file = CSV.readlines('support/riders.csv')

      cleaned_array = read_file.delete_if do |row|
        row == read_file[0]
      end

      riders_array = []
      cleaned_array.map do |params|
        rider = self.new(params[0].to_s, params[1].to_s,  params[2].to_s)

        riders_array << rider
      end
      return riders_array
    end

    # DONE: find a specific rider using their numeric ID
    def self.find(rider_id)
      riders = RideShare::Rider.all
      counter = 0

      riders.each do |rider|
        if rider.rider_id == rider_id
          return rider.name
        else
          counter += 1
        end
      end

    end

    # DONE: retrieve the list of trip instances that only this rider has taken
    # TODO: retrieve the list of all previous driver instances (through the trips functionality built above)
    def trips(rider_id)
      new_instance = RideShare::Trip.new("", "", "", "", "")
      trips = new_instance.find_all_rider_instances(rider_id)
      return trips
    end

    def previous_driver_instances
    end

  end
end

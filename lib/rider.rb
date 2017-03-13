require 'csv'
require 'trip'

module RideShare
  class Rider

    def initialize
      # have an ID, name and phone number

    end

    def self.ceate_all_riders
      # retrieve all riders from the CSV file
    end

    def self.find(rider_id)
      # find a specific rider using their numeric ID
    end

    def trips
      # retrieve the list of trip instances that only this rider has taken
    end

    def unique_drivers
      # retrieve the list of all previous driver instances (through the trips functionality built above)
      # return drivers.uniq { |d| d.id }
    end

  end
end

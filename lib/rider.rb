require 'csv'
require 'trip'

module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone_num
    def initialize(rider_info)
      # have an ID, name and phone number
      @rider_id = rider_info[:rider_id]
      @name = rider_info[:name]
      @phone_num = rider_info[:phone_num]
    end

    def self.create_all_riders
      # retrieve all riders from the CSV file
      CSV.read(
      "support/riders.csv",
      headers: true,
      header_converters: :symbol,
      converters: :all
      ).map { |line| line.to_h }
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

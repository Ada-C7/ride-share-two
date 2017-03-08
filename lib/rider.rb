require 'csv'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(rider_hash)
      @id = rider_hash[:id]
      @name = rider_hash[:name]
      @phone_number = rider_hash[:phone_number]
    end

    def trip
      # retruns list of rider trips
    end

    def self.all
      # reads drivers.csv file
    end

    def self.find
      # finds an instance of the drivers.csv file
    end

  end
end

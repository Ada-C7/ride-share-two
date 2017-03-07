# HAS
# @id, @name, @vin
# have an ID, name, and vehicle identification number
# Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
#
# INSTANCE METHODS
# trips: retrieve the list of trip instances that only this driver has taken
# average_rating: retrieve an average rating for that driver based on all trips taken
#
# CLASS METHODS
# all: retrieve all drivers from the CSV file
# find: find a specific driver using their numeric ID
require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name

    def initialize(params)
      raise ArgumentError.new("VIN must be 17 characters.") if params[:vin].length != 17

      @id = params[:id]
      @name = params[:name]
      @vin = params[:vin]
    end

    def self.all
      @@all ||= CSV.read("support/drivers.csv", headers:true).map do |line|
        Driver.new(
          id: line[0],
          name: line[1],
          vin: line[2]
        )
      end
    end

  end
end

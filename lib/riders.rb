require_relative 'drivers'
require_relative 'trips'
require 'csv'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_num
    def initialize(params)
      @id = params[:rider_id].to_i
      @name = params[:name]
      @phone_num = params[:phone_num]
    end

# this method reads the CSV into the class but does not validate the input
    def self.all
      csv = CSV.open("./support/riders.csv", :headers => true, :header_converters => :symbol)
      csv.map { |row| self.new(row.to_hash) }
    end

#this method calls to trips to find the trip objects for a specifc rider id
    def all_trips
      RideShare::Trip.rider_find(@id)
    end

# this method uses all_trips to return a total cost for all trips a rider has taken
    def total_cost
      all_trips.sum {|trip| trip.cost}
    end

# this method uses all_trips to return the total time for all trips a rider has taken
    def total_time
      all_trips.sum { |trip| trip.duration }
    end

#this method sorts through the CSV data from .all and returns the object with the id equal to what was passed in
    def self.find(id)
      self.all.find { |account| account.id == id }
    end

#this method calls to the all_trips method to return the driver IDs for every trip of a given rider
    def all_drivers
      driver_id = all_trips.map do |trip|
        RideShare::Driver.all.select { |driver| driver.id == trip.driver_id }
      end
    end

  end
end

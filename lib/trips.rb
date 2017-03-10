require_relative 'drivers'
require_relative 'riders'
require 'csv'

module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating, :duration, :cost

    def initialize(params)
      @id = params[:trip_id].to_i
      @driver_id = params[:driver_id].to_i
      @rider_id = params[:rider_id].to_i
      @date = params[:date]
      @rating = params[:rating].to_i
      @cost = params[:cost].to_i
      @duration = params[:duration].to_i
      raise ArgumentError.new "The rating must be between 1 and 5" if @rating > 5 || @rating < 0
    end

# this reads the CSV into the class but does not validate it!
    def self.all
      csv = CSV.open('./support/trips.csv', :headers => true, :header_converters => :symbol)
      csv.map { |row| self.new(row.to_hash) }
    end

# this method searches the trips class(self) by rider_id to return trips by rider
# it is called on in the Rider class to return those trip objects to the rider class
    def self.rider_find(id)
      rider_trips = self.all.select { |trip| trip.rider_id == id }
      raise ArgumentError.new "Sorry, this rider has no trips" if rider_trips.length < 1
      rider_trips
    end

#this method searches the trips class(self) by driver_id to return trips by driver
#it is called on in the Driver class to return trip objects to the driver class
    def self.driver_find(id)
      driver_trips = self.all.select { |trip| trip.driver_id == id}
      raise ArgumentError.new "Sorry, this driver has no trips" if driver_trips.length < 1
      driver_trips
    end

#this method calls on the .all CSV-read method to find a trip by id
    def self.find(id)
      self.all.find { |account| account.id == id }
    end

#this method returns a driver object based on a trip id.
    def driver_for_trip
      driver = RideShare::Driver.find(@driver_id)
      raise ArgumentError.new "This driver does not exist" if driver == nil
      driver
    end

# this method returns a rider object based on a trip id
    def rider_for_trip
      rider = RideShare::Rider.find(@rider_id)
      raise ArgumentError.new "This rider does not exist" if rider == nil
      rider
    end

  end
end

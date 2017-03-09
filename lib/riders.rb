require_relative 'module'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_num
    def initialize(params)
      @id = params[:rider_id].to_i
      @name = params[:name]
      @phone_num = params[:phone_num]
    end

# this method reads the CSV into the class
    def self.all
      csv = CSV.open("./support/riders.csv", :headers => true, :header_converters => :symbol)
      csv.map { |row| self.new(row.to_hash) }
    end

#this method calls to trips to find the trip objects for a specifc rider id
    def all_trips(id)
      RideShare::Trip.rider_find(id)
    end

#this method sorts through the CSV data from .all and returns the object with the id equal to what was passed in
#why don't i have a validation here???
    def self.find(id)
      self.all.find { |account| account.id == id }
    end

#this method calls to the all_trips method to return the driver IDs for every trip of a given rider
# why can't this return driver instances instead?
    def all_drivers(id)
      all_trips(id).map { |trip| trip.driver_id }
    end

  end
end

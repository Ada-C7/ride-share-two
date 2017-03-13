
require "csv"
require "pry"
#require "invalid_data"

module RideShare
  class Rider

    attr_reader :id, :name, :phone_number

    def initialize(args_hash)
      #csv header: rider_id,name,phone_num
      @id = args_hash[:rider_id]
      @name = args_hash[:name]
      @phone_number = args_hash[:phone_num]
    end

    def self.all
      # retrieve all riders from CSV files
      # returns list of all riders instances
      all_riders_array = []
      CSV.read("support/riders.csv", {:headers => true, :header_converters => :symbol}).each do |line|
        all_riders_array << RideShare::Rider.new(line)
      end
      return all_riders_array
    end

    def self.find(rider_id)
      # find a specific rider using numeric ID
      # returns a rider instance
      rider = all.detect {|rider| (rider.id == rider_id) }
      # (rider != nil) ? (return rider) : (raise InvalidData.new "invalid rider id")
    end

    def retrieve_trips
      #retrieve the list of trip instances for a rider
      RideShare::Trip.find_rider_trips(@id)
    end

    def retrieve_drivers
      #retrieve the list of all previous driver instances for a rider
      #returns list of driver instances
      retrieve_trips.map {|trip| RideShare::Driver.find(trip.driver_id)}.uniq
    end
  end
end

# Rider.print_all

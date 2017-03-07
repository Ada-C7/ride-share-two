require 'csv'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(rider_hash)
      raise ArgumentError.new("Invalid argument type: must be a hash object") if rider_hash.class != Hash
      raise ArgumentError.new("Invalid argument type: must have rider id(Integer)") if !rider_hash.keys.include?(:id)
      raise ArgumentError.new("Invalid argument type: must have rider name(String)") if !rider_hash.keys.include?(:name)
      raise ArgumentError.new("Invalid argument type: must have phone_number(String)") if !rider_hash.keys.include?(:phone_number)

      @id = rider_hash[:id]
      @name = rider_hash[:name]
      @phone_number = rider_hash[:phone_number]
    end

    # Retrieve the list of trip instances that only this rider has taken
    def trips
      return Trip.trips_by_rider(@id)
    end

    # Retrieve the list of all previous driver instances
    def drivers
      all_trips_by_rider = trips
      drivers = all_trips_by_rider.map { |trip| Driver.find(trip.driver_id) }
      return drivers
    end

    # Retrieve all riders from the CSV file
    def self.all
      all_riders_array= []
      CSV.read("support/riders.csv").each do |line|
        begin
          all_riders_array << Rider.new( line[0].to_i, line[1], line[2] )
        rescue
          puts "Invalid data entry detected in the CSV file"
        end
      end
      return all_riders_array
    end

    # Find a specific rider using their numeric ID
    def self.find(rider_id)
      raise ArgumentError.new ("Driver id must be a positive integer value") if ( id.class != Integer || id < 1 )
      all_riders_array = Rider.all
      return all_riders_array.select { |rider| rider.id == rider_id }
    end
  end
end

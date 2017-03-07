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
      return RideShare::Trip.trips_by_rider(@id)
    end

    # Retrieve the list of all previous driver instances
    def drivers
      all_trips_by_rider = trips
      drivers = all_trips_by_rider.map { |trip| RideShare::Driver.find(trip.driver_id) }
      return drivers
    end

    # Retrieve all riders from the CSV file
    def self.all
      all_riders_array= []
      CSV.foreach("support/riders.csv", {:headers => true}) do |line|
          all_riders_array << RideShare::Rider.new({id: line[0].to_i, name: line[1], phone_number: line[2]})
      end
      return all_riders_array
    end

    # Find a specific rider using their numeric ID
    def self.find(rider_id)
      raise ArgumentError.new ("Rider id must be a positive integer value") if ( rider_id.class != Integer || rider_id < 1 )
      all_riders_array = RideShare::Rider.all
      raise ArgumentError.new ("That rider ID does not currently exist") if !all_riders_array.any? { |rider| rider.id == rider_id }
      return all_riders_array.select { |rider| rider.id == rider_id }[0]
    end
  end
end

require 'csv'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(rider_hash)
      raise ArgumentError.new("Invalid argument type: must be a hash object") if rider_hash.class != Hash

      [:id, :name, :phone_number].each { |sym_key|
        raise ArgumentError.new("Invalid argument type: must have #{sym_key} value") if !rider_hash.keys.include?(sym_key)
      }

      @id = rider_hash[:id].to_i
      @name = rider_hash[:name].to_s
      @phone_number = rider_hash[:phone_number].to_s
    end

    # Retrieve the list of trip instances that only this rider has taken
    def trips
      trips =  RideShare::Trip.trips_by_rider(@id)
      if trips != nil
        return trips
      else
        return []
      end
    end

    # Retrieve the list of all previous driver instances
    def drivers
      drivers = (trips.map { |trip| RideShare::Driver.find(trip.driver_id) }).compact
      return drivers.uniq { |driver| driver.id }
    end

    # Retrives the total amount cost of all trips by this rider
    def total_cost
      costs = 0
      trips.each { |trip| costs += trip.cost }
      return costs
    end

    # Retrieves the total time spent traveling on all trips by this rider
    def total_duration
      duration = 0
      trips.each { |trip| duration += trip.duration }
      return duration
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
      raise ArgumentError.new ("Rider id must be a positive integer value") if ( rider_id.class != Integer || rider_id < 0 )
      all_riders_array = RideShare::Rider.all
      return nil if !all_riders_array.any? { |rider| rider.id == rider_id }
      return all_riders_array.select { |rider| rider.id == rider_id }[0]
    end
  end
end

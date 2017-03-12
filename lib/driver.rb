require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(driver_hash)
      raise ArgumentError.new("Invalid argument type: must be a hash object") if driver_hash.class != Hash

      [:id, :name, :vin].each { |sym_key|
        raise ArgumentError.new("Invalid argument type: must have #{sym_key} value") if !driver_hash.keys.include?(sym_key)
      }

      @id = driver_hash[:id].to_i
      @name = driver_hash[:name].to_s

      @vin = driver_hash[:vin].to_s
      # The length of the vehicle_id(:vin) must equal 17, to be considered valid
      raise ArgumentError.new("Invalid argument type: vin(String) number must be 17 chracters, mix of letters and numerals") if driver_hash[:vin] !~ /^([a-zA-Z]|\d){17}$/
    end

    # Retrieve the list of trip instances that only this driver has taken
    def trips
      trips = RideShare::Trip.trips_by_driver(id)
      if trips != nil
        return trips
      else
        return []
      end
    end

    # Retrieve an average rating for that driver based on all trips taken
    def avg_rating
      all_trips_by_driver_array = trips
      sum_rate = 0.0
      if all_trips_by_driver_array == []
        return sum_rate
      else
        all_trips_by_driver_array.each { |trip| sum_rate += trip.rating }
        return (sum_rate / all_trips_by_driver_array.length).round(2)
      end
    end

    # Calculate the driver's total revenue for all trips
    # Each driver gets 80% of the trip cost after a fee of $1.65 is subtracted.
    def revenue
      all_trips_by_driver_array = trips
      sum_cost = 0
      if all_trips_by_driver_array == []
        return sum_cost
      else
        all_trips_by_driver_array.each { |trip| sum_cost += ( ( trip.cost - 165 ) * 0.8 ).to_i }
        return sum_cost
      end
    end

    # Retrieve all drivers from the CSV file
    def self.all
      all_drivers_array= []
      CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
        all_drivers_array << RideShare::Driver.new({ id: line[0].to_i, name: line[1], vin: line[2] })
      end
      return all_drivers_array
    end

    # Find a specific driver using their numeric ID
    def self.find(driver_id)
      raise ArgumentError.new ("Driver id must be a positive integer value") if ( driver_id.class != Integer || driver_id < 0 )
      all_drivers_array = RideShare::Driver.all
      return nil if !all_drivers_array.any? { |driver| driver.id == driver_id }
      return (all_drivers_array.select { |driver| driver.id == driver_id })[0]
    end
  end
end

require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(driver_hash)
      raise ArgumentError.new("Invalid argument type: must be a hash object") if driver_hash.class != Hash
      raise ArgumentError.new("Invalid argument type: must have driver id(Integer)") if !driver_hash.keys.include?(:id)
      raise ArgumentError.new("Invalid argument type: must have driver name(String)") if !driver_hash.keys.include?(:name)

      # The length of the vehicle_id(:vin) must equal 17, to be considered valid
      raise ArgumentError.new("Invalid argument type: vin(String) number must be 17 chracters, mix of letters and numerals") if driver_hash[:vin] !~ /^([a-zA-Z]|\d){17}$/

      @id = driver_hash[:id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
    end

    # Retrieve the list of trip instances that only this driver has taken
    def trips
      return RideShare::Trip.trips_by_driver(id)
    end

    # Retrieve an average rating for that driver based on all trips taken
    def avg_rating
      all_trips_by_driver_array = trips
      sum_rate = 0.0
      all_trips_by_driver_array.each { |trip| sum_rate += trip.rating }
      return (sum_rate / all_trips_by_driver_array.legnth).round(2)
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
      raise ArgumentError.new ("Driver id must be a positive integer value") if ( driver_id.class != Integer || driver_id < 1 )
      all_drivers_array = RideShare::Driver.all
      raise ArgumentError.new ("That driver ID does not currently exist") if !all_drivers_array.any? { |driver| driver.id == driver_id }
      return all_drivers_array.select { |driver| driver.id == driver_id}[0]
    end
  end
end

require 'csv'
require_relative 'trip'

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
  end

  # Retrieve an average rating for that driver based on all trips taken
  def avg_rating
  end

  # Retrieve all drivers from the CSV file
  def self.all
  end

  # Find a specific driver using their numeric ID
  def self.find(id)
  end
end

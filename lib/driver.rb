require 'csv'
require_relative './trip.rb'

class Driver
  attr_reader :id, :name, :vin

  def initialize(driver_hash)
    @id = driver_hash[:id]
    @name = driver_hash[:name]
    @vin = driver_hash[:vin]
  end

  def self.all
    all_drivers = []
    driver_file = CSV.open("support/drivers.csv")
    # creates and collects instances of Driver from CSV file
    driver_hash = {}
    driver_file.each do |line|

      driver_hash[:id] = line[0].to_i
      driver_hash[:name] = line[1]
      driver_hash[:vin] = line[2]

      # TODO: test VIN - must have 17 digits and must not contain I, O or Q
      unless driver_hash[:name] == "name"
        all_drivers << Driver.new(driver_hash)
      end
    end

    return all_drivers
  end

  def get_trips
    # passes driver id to Trip.find_trips_by_driver
    # returns collection of trips taken by this driver
  end

  def avg_rating
    # calls get_trips
    # calculates average rating across all trips
  end



  def self.find
    # finds a specific instance of Driver based on driver ID
  end
end

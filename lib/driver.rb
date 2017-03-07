require 'csv'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name
    @vin = vin
  end

  def self.all

    drivers = CSV.read("support/drivers.csv", { :headers => true })
    drivers_array = []

    drivers.each do |line|
      drivers_array << Driver.new(line[0].to_i, line[1], line[2])
    end

    return drivers_array
    # read SCV
    # returns a list of driver instances
  end

  def self.find(driver_id)
    # searches .all for all driver matching parameter
    # returns an instance of a driver
  end

  def lists_trips
    # passes driver ID to find_trips_per_driver
    # returns a list of trip instances only this driver has taken
  end

  def avg_rating
    # accesses rating form each trip instance
    # calcualtes average
    # returns an average rating for that driver based on all trips taken
  end

end

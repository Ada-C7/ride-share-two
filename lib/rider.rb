require 'csv'
require_relative 'trip'
require_relative 'driver'

class Rider
  attr_reader :id, :name, :phone_num

  @@all_riders = nil

  def initialize(id, name, phone_num)
    @id = id
    @name = name
    @phone_num = phone_num
  end

  def self.all
    # reads CSV
    # returns a list of all rider instances
    return @@all_riders if @@all_riders
    riders = CSV.read("support/riders.csv", { :headers => true })

    @@all_riders = riders.map { |line| Rider.new(line[0].to_i, line[1], line[2]) }

    return @@all_riders
  end

  def self.find(rider_id)
    unless (rider_id.is_a? Integer) && rider_id >= 0
      raise ArgumentError.new("rider ID:#{rider_id} is not valid")
    end
    # searches .all for rider matching the parameter
    # returns a driver instance
    Rider.all.find { |rider| rider.id == rider_id }
  end

  def list_trips
    # looks for all trips associated with just one rider
    # passes rider_id to find_trips_per_rider
    # returns a list of trip instances only this rider has taken
    Trip.find_trips_rider(@id)
  end

  def list_drivers
    # looks for all drivers associated with just one rider
    # accesses list of trip instances from lists_trips
    # returns lists of all previous driver instances assoicated with this rider
    drivers = list_trips.map { |trip| Driver.find(trip.driver_id) }

    drivers.uniq { |driver| driver.id }
  end

end

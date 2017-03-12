require 'csv'
require_relative 'trip'

class Driver
  attr_reader :id, :name, :vin

  @@all_drivers = nil

  def initialize(id, name, vin)
    @id = id
    @name = name

    if vin.length == 17
      @vin = vin
    else
      raise ArgumentError.new("Vin must be 17 characters long.")
    end
  end

  def self.all
    # read CSV
    # returns a list of driver instances
    return @@all_drivers if @@all_drivers
    drivers = CSV.read("support/drivers.csv", { :headers => true })

    @@all_drivers = drivers.map { |line| Driver.new(line[0].to_i, line[1], line[2]) }
    return @@all_drivers
  end

  def self.find(driver_id)
    unless (driver_id.is_a? Integer) && driver_id >= 0
      raise ArgumentError.new("driver ID:#{driver_id} is not valid")
    end
    # searches .all for all driver matching parameter
    # returns an instance of a driver
    Driver.all.find { |driver| driver.id == driver_id }
    # return found_driver if found_driver
  end

  def list_trips
    # passes driver ID to find_trips_per_driver
    # returns a list of trip instances only this driver has taken
    Trip.find_trips_driver(@id)
  end

  def avg_rating
    # accesses rating form each trip instance
    # calcualtes average
    # returns an average rating for that driver based on all trips taken
    ratings = list_trips.map { |trip| trip.rating.to_f }
    return 0 if ratings == []
    rating = (ratings.reduce(:+)) / ratings.length
    rating.round(2)
  end

end

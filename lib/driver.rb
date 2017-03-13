require 'csv'
require_relative 'trip'
require_relative 'InvalidVinError'
require_relative 'InvalidIDError'

class Driver
  attr_reader :id, :name, :vin

  @@all_drivers = nil

  def initialize(id, name, vin)
    @id = id
    @name = name

    if vin.length == 17
      @vin = vin
    else
      raise InvalidVinError.new("vin must be 17 characters long")
    end
  end

  def self.all
    return @@all_drivers if @@all_drivers
    drivers = CSV.read("support/drivers.csv", { :headers => true })

    @@all_drivers = drivers.map { |line| Driver.new(line[0].to_i, line[1], line[2]) }
  end

  def self.find(driver_id)
    unless (driver_id.is_a? Integer) && driver_id >= 0
      raise InvalidIDError.new("driver ID:#{driver_id} is not valid")
    end

    Driver.all.find { |driver| driver.id == driver_id }
  end

  def list_trips
    Trip.find_trips_driver(@id)
  end

  def avg_rating
    ratings = list_trips.map { |trip| trip.rating.to_f }
    return 0 if ratings == []
    rating = (ratings.reduce(:+)) / ratings.length
    rating.round(2)
  end

end

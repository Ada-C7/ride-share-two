require 'csv'
require 'pry'
require_relative 'trip'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name
    raise ArgumentError.new("VIN must be 17 characters") if vin.length != 17
    @vin = vin
  end

  def self.all
    drivers = []
    # binding.pry
    CSV.foreach("./support/drivers.csv", {:headers => true}).each do |line|
      id = line[0].to_i
      name = line[1]
      vin = line[2]

      drivers << Driver.new(id, name, vin)
    end
    return drivers
  end

  def self.find(search_id)
    # drivers = self.all
    # match = false
    match = nil
    self.all.each do |driver|
      if driver.id.to_i == search_id
          match = driver
          break
      else
        match = nil
      end
    end
    raise ArgumentError.new("There are no drivers with that match") if match == nil
    return match

    # binding.pry

  end

  def trips
    driver_trips = []
    Trip.all.each do |trip|
      if trip.driver == @id
        driver_trips << trip
      end
    end
    return driver_trips
  end

  def average
    rating = 0
    trips.each do |trip|
      rating += trip.rating
    end

    return rating = rating.to_f / trips.length

  end

end

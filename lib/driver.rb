require 'csv'
require 'pry'
require_relative 'trip'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id.to_i
    @name = name
    raise ArgumentError.new("VIN must be 17 characters") if vin.length != 17
    @vin = vin.to_s
  end

  def self.all
    drivers = []
    # binding.pry
    CSV.foreach("./support/drivers.csv", {:headers => true}).each do |line|
      id = line[0].to_i
      name = line[1]
      vin = line[2].to_s

      drivers << Driver.new(id, name, vin)
    end
    return drivers
  end

  def self.find(search_id)
    # drivers = self.all
    # match = false
    self.all.each do |driver|
      if driver.id == search_id
          return driver
      end
    end
    raise ArgumentError.new("There are no drivers with that match")

    # binding.pry

  end

  def trips
    driver_trips = []
    Trip.all.map { |trip| driver_trips << trip if trip.driver == @id }
        
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

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
    return @@all_riders if @@all_riders
    riders = CSV.read("support/riders.csv", { :headers => true })

    @@all_riders = riders.map { |line| Rider.new(line[0].to_i, line[1], line[2]) }

    return @@all_riders
  end

  def self.find(rider_id)
    unless (rider_id.is_a? Integer) && rider_id >= 0
      raise ArgumentError.new("rider ID:#{rider_id} is not valid")
    end

    Rider.all.find { |rider| rider.id == rider_id }
  end

  def list_trips
    Trip.find_trips_rider(@id)
  end

  def list_drivers
    drivers = list_trips.map { |trip| Driver.find(trip.driver_id) }

    drivers.uniq { |driver| driver.id }
  end

end

require 'csv'
require_relative 'trip'
require_relative 'driver'


class Rider
  attr_reader :id, :name, :phone

  def initialize(rider_id,name,phone_num)
    @id = rider_id
    @name = name
    @phone = phone_num
  end

  def self.all
    riders = []
    CSV.foreach("./support/riders.csv", {:headers => true}) do |line|
      id = line[0]
      name = line[1]
      phone = line[2]

      riders << Rider.new(id, name, phone)

    end
    return riders
  end

  def trips
    rider_trips = []
    Trip.all.each do |trip|
      if trip.rider == @id
        rider_trips << trip
      end
    end
    return rider_trips
  end

  def drivers
    rider_driver_ids = []
    trips.each do |trip|
      rider_driver_ids << trip.driver
    end

    rider_driver_ids = rider_driver_ids.uniq

    rider_drivers = []
    Driver.all.each_with_index do |driver, index|
      if driver.id == rider_driver_ids[index]
        rider_drivers << driver
      end

    end
    return rider_drivers

  end

end

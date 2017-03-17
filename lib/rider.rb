require 'csv'
require_relative 'trip'
require_relative 'driver'


class Rider
  attr_reader :id, :name, :phone

  def initialize(rider_id, name, phone_num)
    raise ArgumentError.new("rider_id must be integer") if rider_id.class != Integer
    @id = rider_id.to_i
    @name = name
    @phone = phone_num
  end

  def self.all
    riders = []
   CSV.foreach("./support/riders.csv", {:headers => true}) do |line|
      id = line[0].to_i
      name = line[1]
      phone = line[2]

      riders << Rider.new(id, name, phone)
    end
    return riders
  end

  def self.find(search_id)
    all_riders = self.all

    all_riders.each {|rider| return rider if rider.id == search_id }

    raise ArgumentError.new("There were no riders with that ID")

  end

  def trips
    Trip.rider_find_all(@id)

    # original code I wrote was below... before Jou-Jou helped me realize that I can just call a method from the Trip class..which was essentially the same exact code... which was the whole point of this project -_-

    # rider_trips = []
    # Trip.all.each do |trip|
    #   if trip.rider == @id
    #     rider_trips << trip
    #   end
    # end
    # return rider_trips
  end

  def drivers

    drivers = {}
    trips.map { |trip| drivers[trip.driver_id] = Trip.driver(trip.driver_id) }

    return drivers.values


    # drivers = {}
    #
    # trips.map { |trip| drivers[trip.driver_id] = 1 }
    #
    # drivers.each { |id, value| drivers[id] = Driver.find(id) }
    #
    # return drivers.values

    #original code I wrote before... Haley the tutor helped me refactor code using a hash

    # rider_driver_ids = []
    # trips.each do |trip|
    #   rider_driver_ids << trip.driver
    # end
    #
    # rider_driver_ids = rider_driver_ids.uniq
    #
    # rider_drivers = []
    # Driver.all.each do |driver|
    #   if rider_driver_ids.include?(driver.id)
    #     rider_drivers << driver
    #   end
    #
    # end
    # return rider_drivers
  end
end

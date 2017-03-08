require 'csv'

class Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

  @@all_trips = nil

  def initialize(id, driver_id, rider_id, date, rating)
    @id = id
    @driver_id = driver_id
    @rider_id = rider_id
    @date = date
    @rating = rating
  end

  def self.all
    # reads CSV
    # returns a list of all trip instances
    return @@all_trips if @@all_trips
    trips = CSV.read("support/trips.csv", { :headers => true })

    @@all_trips = trips.map do |line|
      Trip.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
    end

    return @@all_trips
  end

  def self.find_trips_driver(driver_id)
    # searches .all for trips matching the driver_id
    # returns a list of trip instances associated with one driver
    # trips = []
    # Trip.all.each do |trip|
    #   if trip.driver_id == driver_id
    #     trips << trip
    #   end
    # end

    Trip.all.select { |trip| trip.driver_id == driver_id }

    # return trips
  end

  def self.find_trips_rider(rider_id)
    # searches .all for trips matching the rider_id
    # returns a list of trip instances associated with one rider
    # trips = []
    # Trip.all.each do |trip|
    #   if trip.rider_id == rider_id
    #     trips << trip
    #   end
    # end
    Trip.all.select { |trip| trip.rider_id == rider_id }
    # return trips
  end

  def driver
    # looks for a specific driver of a specific trip
    # passes driver_id to find
    # returns a driver instance
    Driver.find(@driver_id)
    # if I look driver and cannot driver (driver 0)
    # it should give me a driver back and I should do something
  end

  def rider
    # looks for a specific rider of a specific trip
    # passes rider_id to find
    # returns a rider instance
  end

end

require 'csv'

class Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

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
    trips = CSV.read("support/trips.csv", { :headers => true })
    trips_array = []

    trips.each do |line|
      trips_array << Trip.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
    end

    return trips_array
  end

  def self.find_trips_driver(driver_id)
    # searches .all for trips matching the driver_id
    # returns a list of trip instances associated with one driver
    trips = []
    Trip.all.each do |trip|
      if trip.driver_id == driver_id
        trips << trip
      end
    end

    return trips
  end

  def self.find_trips_rider(rider_id)
    # searches .all for trips matching the rider_id
    # returns a list of trip instances associated with one rider
  end

  def driver
    # passes driver_id to find
    # returns a driver instance
  end

  def rider
    # passes rider_id to find
    # returns a rider instance
  end

end

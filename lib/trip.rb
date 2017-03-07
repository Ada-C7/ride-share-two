require 'csv'

class Trip
  attr_reader :id, :driver_id, :rider_id

  def initialize(id, rider_id, driver_id, date, rating)
    @id = id
    @rider_id = rider_id
    @driver_id = driver_id
    @date = date
    @rating = rating
  end

  def self.all
    # reads CSV
    # returns a list of all trip instances
  end

  def self.find_trips_per_driver(driver_id)
    # searches .all for trips matching the driver_id
    # returns a list of trip instances associated with one driver
  end

  def self.find_trips_per_rider
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

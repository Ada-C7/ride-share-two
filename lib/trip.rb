class Trip
  attr_reader :id, :rider_id, :driver_id, :date, :rating

  def initialize(trip_hash)
    # Each rating should be within an acceptable range (1-5)
  end

  # Retrieve the associated driver instance through the driver ID
  def find_driver(driver_id)
  end

  # Retrieve the associated rider instance through the rider ID
  def find_rider(rider_id)
  end

  # Find all trip instances for a given driver ID
  def self.all
  end

  # Find all trip instances for a given rider ID
  def self.trips_by_driver(driver_id)
  end

  # Retrieve all trips from the CSV file
  def self.trips_by_rider(rider_id)
  end
end

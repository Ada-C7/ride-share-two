class Driver
  attr_reader :id, :name, :vin

  def initialize(driver_hash)
    # The length of the vehicle_id(:vin) must be __, to be considered valid
    VIN_LENGTH = 17

  end

  # Retrieve the list of trip instances that only this driver has taken
  def trips
  end

  # Retrieve an average rating for that driver based on all trips taken
  def avg_rating
  end

  # Retrieve all drivers from the CSV file
  def self.all
  end

  # Find a specific driver using their numeric ID
  def self.find(id)
  end
end

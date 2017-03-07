
class RideShare::Trip
  attr_reader :id

  def initialize(id, driver_id, rider_id, date, rating)
    @id = id
    @driver_id = driver_id
    @rider_id = rider_id
    @date = date

    unless rating > 0 && rating < 6
      raise InvalidRatingError.new("Ride rating must be 1-5")
    end
    @rating = rating
  end

  def self.find_all
    # Retrieve all trips from CSV file CLASS METHOD
    #   input: calling Class method Trips.find_all
    #   output: list all trips from CSV file as an array.
  end

  # Retrieve associated driver instance through driver ID
  #   input: Driver ID
  #   output: Driver Object associated w/ trip
  #
  # Retrieve associated Rider instance through Rider ID
  #   input: Rider ID
  #   output: Rider object associated w/ trip
  #
  # Find all trip instances (driver) CLASS METHOD
  #   input: Driver ID
  #   output: list (ARRAY) of all trip instances for that Driver
  #
  # Find all trip instances (rider) CLASS METHOD
  #   input: Rider ID
  #   output: list (ARRAY) of all trip instances for that Rider
  #
  # Retrieve all trips from CSV file CLASS METHOD
  #   input: calling Class method Trips.find_all
  #   output: list all trips from CSV file.
end

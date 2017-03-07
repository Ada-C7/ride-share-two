
class RideShare::Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

  def initialize(id, driver_id, rider_id, date, rating)
    @id = id
    @driver_id = driver_id
    @rider_id = rider_id
    @date = date

    unless rating > 0 && rating < 6
      raise InvalidRatingError.new("Ride rating must be 1-5, your rating was #{ rating }")
    end
    @rating = rating
  end

  def self.find_all
    trips = []
      CSV.open("support/trips.csv").each do |trip|
        begin
          trips << RideShare::Trip.new(trip[0].to_i, trip[1].to_i, trip[2].to_i, trip[3], trip[4].to_i)
        rescue InvalidRatingError => e
          puts "#{ e }"
        end
      end
      # trips.shift => I guess I don't need this.
      return trips
  end

  def self.find_all_driver(driver_id)
    all_trips = find_all
    driver_trips = []

    all_trips.each do |trip|
      if trip.driver_id == driver_id
        driver_trips << trip
      end
    end

    return driver_trips
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

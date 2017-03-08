
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

    return 0 if driver_trips.empty?
    driver_trips
  end

  def self.find_all_rider(rider_id)
    all_trips = find_all
    rider_trips = []

    all_trips.each do |trip|
      if trip.rider_id == rider_id
        rider_trips << trip
      end
    end

    return 0 if rider_trips.empty?
    rider_trips
  end

  def find_driver
    RideShare::Driver.find_driver(@driver_id)
  end

  def find_rider
    RideShare::Rider.find_rider(@rider_id)
  end

end

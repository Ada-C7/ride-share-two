require 'csv'

class Trip
  attr_reader :id, :driver, :rider, :date, :rating

  def initialize(trip_id, driver_id, rider_id, date, rating)
    @id = trip_id
    @driver = driver_id
    @rider = rider_id
    @date = date
    raise ArgumentError.new("rating must be an integer 1-5") if rating <= 0 || rating > 5 || rating.class != Integer
    @rating = rating

  end

  def self.all
    trips = []

    CSV.foreach("./support/trips.csv", {:headers => true}) do |line|
      id = line[0].to_i
      driver = line[1].to_i
      rider = line[2].to_i
      date = line[3]
      rating = line[4].to_i

      trips << Trip.new(id, driver, rider, date, rating)
    end
    return trips

  end

  def self.rider_find_all(search_id)
    rider_trips = []
    all_trips = self.all

    all_trips.each do |trip|
      if trip.rider == search_id
        rider_trips << trip
      end
    end

    raise ArgumentError.new("no matching trips for that rider") if rider_trips.length == 0

    return rider_trips

  end

end

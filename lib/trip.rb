require 'csv'

class Trip
  attr_reader :id, :driver, :rider, :date, :rating

  def initialize(trip_id, driver_id, rider_id, date, rating)
    @id = trip_id.to_i
    @driver = driver_id.to_i
    @rider = rider_id.to_i
    @date = date
    raise ArgumentError.new("Rating must be an integer 1-5") if rating <= 0 || rating > 5 || rating.class != Integer
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
    raise ArgumentError.new("The ID you want to search for must be an integer") if search_id.class != Integer
    rider_trips = []
    all_trips = self.all

    all_trips.each do |trip|
      if trip.rider == search_id
        rider_trips << trip
      end
    end

    raise ArgumentError.new("No matching trips for that rider") if rider_trips.length == 0

    return rider_trips

  end


  def self.driver_find_all(search_id)
    raise ArgumentError.new("The ID you want to search for must be an integer") if search_id.class != Integer
    driver_trips = []
    all_trips = self.all

    all_trips.each do |trip|
      if trip.driver == search_id
        driver_trips << trip
      end
    end

    raise ArgumentError.new("No matching trips for that driver") if driver_trips.length == 0

    return driver_trips
  end


end

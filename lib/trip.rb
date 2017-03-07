require 'csv'

class Trip
  attr_reader :id, :driver, :rider, :date, :rating

  def initialize(trip_id, driver_id, rider_id, date, rating)
    @id = trip_id
    @driver = driver_id
    @rider = rider_id
    @date = date
    @rating = rating

  end

  def self.all
    trips = []

    CSV.foreach("./support/trips.csv", {:headers => true}) do |line|
      id = line[0]
      driver = line[1]
      rider = line[2]
      date = line[3]
      rating = line[4]

      trips << Trip.new(id, driver, rider, date, rating)
    end
    return trips

  end
end

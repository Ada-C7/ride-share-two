class Trip
  attr_reader :id, :driver, :rider, :date, :rating

  def initialize(trip_id, driver_id, rider_id, date, rating)
    @id = trip_id
    @driver = driver_id
    @rider = rider_id
    @date = date
    @rating = rating

  end

end

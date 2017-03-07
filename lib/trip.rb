module RideShareTwo
  class Trip
    attr_reader :trip_id, :rider_id, :driver_id, :date, :rating
    def initialize(trip_id, rider_id, driver_id, date, rating)
      @trip_id = trip_id
      @rider_id = rider_id
      @driver_id = driver_id
      @date = date
      @rating = rating
      # raise ArgumentError.new("rating must be >= 5") if rating < 5
    end

  end

end

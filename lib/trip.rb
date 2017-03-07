module RideShareTwo
  class Trip

    attr_reader :trip_id, :rider_id, :driver_id, :date, :rating

    def initialize(trip_id, rider_id, driver_id, date, rating)
      @trip_id = trip_id
      @rider_id = rider_id
      @driver_id = driver_id
      @date = date
      @rating = rating
        raise ArgumentError.new("rating must be 1-5") if rating >= 6 || rating <= 0
    end

    # def trip_driver
    #   return driver_id #fix - must return instance, use find_driver in driver
    # end
    #
    # def trip_rider
    #   return rider_id #fix - must return instance, use
    # end

  end

end

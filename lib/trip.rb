# module RideShare

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

  end

# end

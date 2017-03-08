module RideShare
  class Trip
    attr_reader :id, :rider_id, :driver_id, :date, :rating

    def initialize(args)
      valid_rating?(args[:rating]) if args[:rating] != nil

      @id = args[:id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]
    end

  # retrieves the associated driver instance through the driver ID
    def driver
      Driver.find(@driver_id)
    end

    private

    def valid_rating?(rating)
      unless (rating.is_a? Integer)
        raise ArgumentError.new("rating must be an int")
      end

      unless rating >= 1 && rating <= 5
        raise InvalidRatingError.new("Rating must be between 1-5, inclusive")
      end
    end
  end
end

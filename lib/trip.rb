module RideShare
  class Trip
    attr_reader :id, :rider_id, :driver_id, :date, :rating

    def initialize(args)
      check_if_valid_rating(args[:rating]) if args[:rating] != nil

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

    # retrieves the associated rider instance through the rider ID
    def rider
      Rider.find(@rider_id)
    end

    private

    #or verify rating
    def check_if_valid_rating(rating)
      unless (rating.is_a? Integer)
        raise ArgumentError.new("rating must be an int")
      end

      unless rating >= 1 && rating <= 5
        raise InvalidRatingError.new("Rating must be between 1-5, inclusive")
      end
    end
  end
end

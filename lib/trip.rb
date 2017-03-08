module RideShare
  class Trip
    attr_reader :id, :rider_id, :driver_id, :date, :rating

    def initialize(args)
      unless args[:rating].is_a? Integer
        raise ArgumentError.new("rating must be an int")
      end

      unless args[:rating] >= 1 && args[:rating] <= 5
        raise InvalidRatingError.new("Rating must be between 1-5, inclusive")
      end

      @id = args[:id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]
    end
  end
end

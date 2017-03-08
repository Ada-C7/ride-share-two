module RideShare
  class Trip
    attr_reader :id, :rider_id, :driver_id, :date, :rating

    def initialize(args)
      raise ArgumentError.new("rating must be an int") unless args[:rating].is_a? Integer

      @id = args[:id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]
    end
  end
end

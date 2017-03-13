require 'csv'

module RideShare
  class Trips
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trips)

      @trip_id = trips[:trip_id]
      @driver_id = trips[:driver_id]
      @rider_id = trips[:rider_id]
      @date = trips[:date]
      @rating = trips[:rating]

    raise ArgumentError.new("Invalid Rating") if trips[:rating] > 5 || trips[:rating] < 1
    end

    # def rating_range(input)
    #   input
    # end
  end # end of Trip
end # end of module

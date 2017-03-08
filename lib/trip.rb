require 'csv'
module RideShare
  class Trip
    attr_accessor :trip_id, :driver_id, :rider_id, :date, :rating
    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end

    def find_many(id)
      # driver_trips = []
      # trips = self.all
      #
      # trips.each do |trip|
      #   if driver_id == id
      #     driver_trips << trip
      #     return driver_trips
      #   end
      # end
    end

  end
end

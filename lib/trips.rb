module RideShare

  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end


    def self.all
      trips_array = []
      CSV.read("support/trips.csv").each do |trip|
        trips_array << Trip.new(trip[0], trip[1], trip[2], trip[3], trip[4])
      end
      trips_array
    end


  end
end

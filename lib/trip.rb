module RideShare
  class Trip
    attr_reader :trip_id, :rider_id, :driver_id, :date, :rating
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @trip_id = hash[:trip_id]
      @rider_id = hash[:rider_id]
      @driver_id = hash[:driver_id]
      @date = hash[:date]
      @rating = hash[:rating]
    end

    def driver(driver_id) # ????????????
        #retrieve the associated driver instance through the driver ID
    end

    def rider(rider_id) # ????????????
        #retrieve the associated driver instance through the driver ID
    end

    # find all trip instances for a given driver ID

    # find all trip instances for a given rider ID
    
    # retrieve all trips from the CSV file

  end
end

trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}

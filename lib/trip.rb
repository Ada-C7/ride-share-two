module RideShare
  class Trip
    attr_reader :trip_id, :rider_id, :driver_id, :date
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @trip_id = hash[:trip_id]
      @rider_id = hash[:rider_id]
      @driver_id = hash[:driver_id]
      @date = hash[:date]
    end

    def driver(driver_id)

    end

  end
end

trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017"}

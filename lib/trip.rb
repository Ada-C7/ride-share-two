require_relative 'driver'
require_relative 'rider'
module RideShare
  class Trip
    attr_reader :trip_id, :rider_id, :driver_id, :date, :rating
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @trip_id = hash[:trip_id]
      @rider_id = hash[:rider_id]
      @driver_id = hash[:driver_id]
      @date = hash[:date]
      raise ArgumentError.new("Raiting should be 1 - 5 only") if !((1..5).include? hash[:rating])
      @rating = hash[:rating]
    end

    def driver# ????????????
        #retrieve the associated driver instance through the driver ID
        return RideShare::Driver.find(@driver_id)
    end

    def rider
        #retrieve the associated driver instance through the driver ID
        return RideShare::Rider.find(@@rider_id)
    end

    # find all trip instances for a given driver ID

    # find all trip instances for a given rider ID

    # retrieve all trips from the CSV file

  end
end

trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}

trip = RideShare::Trip.new(trip_hash)
puts trip.driver.driver_id

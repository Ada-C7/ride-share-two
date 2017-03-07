require "csv"

module RideSharing
  class Trip

    attr_reader :id, :driver_id, :rider_id, :date, :rating
    def initialize(id, driver_id, rider_id, date, rating)
      @id = id.to_i
      @driver_id = driver_id.to_i
      @rider_id = rider_id.to_i
      @date = date
      @rating = rating.to_i

    end

  end # End of class Trip
end # End of module RideSharing

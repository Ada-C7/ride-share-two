module RideShare

  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating
    def initialize(trip_hash)
      # raise error if rating is not valid
      @id = trip_hash[:id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
    end

    def self.all
      # creates instances of Trip from CSV
      # include rescue for invalid rating
    end

    def self.find_by_driver
      # returns all Trip instances with given driver ID
    end

    def self.find_by_rider
      # returns all Trip instances with given rider ID
    end

    def get_driver
      # retrieve Driver instance with this trip's driver_id
    end

    def get_rider
      # retrieve Rider instance with this trip's rider_id
    end

  end
end

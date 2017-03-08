module RideShare

  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_hash)
      unless trip_hash[:rating] > 0 && trip_hash[:rating] < 6
        raise InvalidRatingError.new("Rating must be in the range 1-5")
      end

      @id = trip_hash[:id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
    end

    def self.find_by_driver(driver_id)
      # returns all Trip instances with given driver ID
      Trip.all.select {|trip| trip.driver_id == driver_id}
    end

    def self.find_by_rider(rider_id)
      # returns all Trip instances with given rider ID
      Trip.all.select {|trip| trip.rider_id == rider_id}
    end

    def get_driver
      # retrieve Driver instance with this trip's driver_id
      Driver.find(driver_id)
    end

    def get_rider
      # retrieve Rider instance with this trip's rider_id
      Rider.find(rider_id)
    end

    private

    def self.all
      all_trips = []
      trip_hash = {}

      CSV.foreach("support/trips.csv", {:headers => true}) do |line|
          trip_hash[:id] = line[0].to_i
          trip_hash[:driver_id] = line[1].to_i
          trip_hash[:rider_id] = line[2].to_i
          trip_hash[:date] = line[3]
          trip_hash[:rating] = line[4].to_i

          begin
            all_trips << Trip.new(trip_hash)
          rescue InvalidRatingError => e
            puts "Encountered an error: #{e.message}"
          end
      end
      return all_trips
    end




  end
end

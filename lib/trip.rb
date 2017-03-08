require "csv"

module RideShareTwo
  class Trip

    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
        raise ArgumentError.new("rating must be 1-5") if rating >= 6 || rating <= 0
    end

# find all trip instances for a given driver ID
    def self.driver_trips(driver_id)
      drivers_trips = []
      # trip_array = self.all_trips
      all_trips.each do |trip|
        if trip.driver_id.to_i == driver_id
          drivers_trips << trip
        end
      end
      # puts drivers_trips
      return drivers_trips
    end

      # driver_trip_count = 0
      # self.all_trips.each do |index|
      #   if index.driver_id == driver_id
      #     driver_trip_count += 1
      #   end
      # end
      # return driver_trip_count
      # drivers_trips = []
      # return driver_id #fix - must return instance, use find_driver in driver
    # end



    #
    # def trip_rider
    #   return rider_id #fix - must return instance, use
    # end

    def self.all_trips
      all_trips = []
      CSV.open("support/trips.csv",{:headers => true}).each do |array|
        all_trips << self.new(array[0].to_i, array[1].to_i, array[2].to_i, array[3], array[4].to_i)
      end
      return all_trips
    end

  end

end

# puts RideShareTwo::Trip.all_trips[1].driver_id
# puts RideShareTwo::Trip.driver_trips(1)

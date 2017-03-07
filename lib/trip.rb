module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize trip_id, driver_id, rider_id, date, rating
      @id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end

    def self.all
      trips = []
      temp_csv = CSV.read("/Users/sai/Documents/ada/projects/ride-share-two/support/trips.csv")
      temp_csv.shift #removes first row, which is a header row (thx, google)
      temp_csv.each do |trip|
        trips << Trip.new(trip[0].to_i, trip[1].to_i, trip[2].to_i, trip[3], trip[4].to_i)
      end

      return trips
      #check to make sure that ratings are valid?
      #reads trips.csv and puts info into array of Trip instances
    end

    def self.find_trips_by_rider rider_id
      all_trips = Trip.all
      rider_trips = all_trips.find_all { |trip| trip.rider_id == rider_id }
      if rider_trips.length > 0
        return rider_trips
      else
        return nil
      end
      #call all
      #search by rider_id to return array of Trip instances associated with that rider
    end

    def self.find_trips_by_driver
      #call all
      #search by driver to return array of Trip instances associated with that driver
    end

    def driver
      #call Driver.find to return Driver instance associated with the driver_id of the trip instance
    end

    def rider
      #call Rider.find to return Rider instance associated with the rider_id of the trip instance
    end

  end
end

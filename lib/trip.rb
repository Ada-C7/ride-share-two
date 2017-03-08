require 'csv'
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
      return all_trips.find_all { |trip| trip.rider_id == rider_id }
      #call all
      #search by rider_id to return array of Trip instances associated with that rider
    end

    def self.find_trips_by_driver driver_id
      all_trips = Trip.all
      return all_trips.find_all { |trip| trip.driver_id == driver_id }
      #will return empty array if no trips found
    end

    def driver
      driver_info = Driver.find @driver_id
      return driver_info
      #call Driver.find to return Driver instance associated with the driver_id of the trip instance
    end

    def rider
      rider_info = Rider.find @rider_id
      return rider_info
      #call Rider.find to return Rider instance associated with the rider_id of the trip instance
    end

  end
end

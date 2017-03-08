require 'csv'
require 'bad_rating_error'

module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize trip_id, driver_id, rider_id, date, rating
      raise ArgumentError.new("Trip ID needs to be an integer; entry is #{trip_id}") if trip_id.class != Integer

      raise ArgumentError.new("Driver ID needs to be an integer; entry is #{driver_id}") if driver_id.class != Integer

      raise ArgumentError.new("Rider ID needs to be an integer; entry is #{rider_id}") if rider_id.class != Integer

      raise ArgumentError.new("Date must be of format YYYY-MM-DD; entry is #{date}") if (date !~ /^201[4-7]-(0[\d]||1[0-2])-([0-2][\d]||3[01])$/)

      raise BadRatingError.new("Rating needs to be between 1 and 5; entry is #{rating}") if rating.class != Integer || rating < 1 || rating > 5

      @id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end

    def self.all
      trips = []
      temp_csv = CSV.read("support/trips.csv")
      temp_csv.shift #removes first row, which is a header row (thx, google)


      temp_csv.each do |trip|
        begin
          trips << Trip.new(trip[0].to_i, trip[1].to_i, trip[2].to_i, trip[3], trip[4].to_i)
        rescue
          puts "Rating needs to be a number between 1 and 5. You entered: #{trip[4]}.\nEntry not included. Please update CSV file."
        end
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
      return Rider.find @rider_id
      #call Rider.find to return Rider instance associated with the rider_id of the trip instance
    end

  end
end

require 'csv'
require 'bad_rating_error'

module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating, :cost, :duration

    def initialize trip_hash
      #check if inputs are valid
      validate_input(trip_hash)

      @id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
      @cost = trip_hash[:cost] #2 decimal places
      @duration = trip_hash[:duration] #in minutes

    end

    def self.all

      trips = []
      temp_csv = CSV.read("support/trips.csv")
      temp_csv.shift #removes first row, which is a header row (thx, google)

      temp_csv.each do |trip|
        trip_hash = Hash.new
        trip_hash[:trip_id] = trip[0].to_i
        trip_hash[:driver_id] = trip[1].to_i
        trip_hash[:rider_id] = trip[2].to_i
        trip_hash[:date] = trip[3]
        trip_hash[:cost] = trip[5].to_f
        trip_hash[:duration] = trip[6].to_i
        trip_hash[:rating] = trip[4].to_i

        begin
          trips << Trip.new(trip_hash)
        rescue BadRatingError #specify which error to rescue otherwise will rescue all raised Errors
          puts "Rating needs to be a number between 1 and 5. You entered: #{trip[4]}.\nEntry not included. Please update CSV file."
        end



      end

      return trips
    end

    def self.find_trips_by_rider rider_id
      all_trips = Trip.all
      return all_trips.find_all { |trip| trip.rider_id == rider_id }
    end

    def self.find_trips_by_driver driver_id
      all_trips = Trip.all
      return all_trips.find_all { |trip| trip.driver_id == driver_id }
    end

    def driver
      return Driver.find @driver_id
    end

    def rider
      return Rider.find @rider_id
    end

    private

    def validate_input trip_hash
      raise ArgumentError.new("Trip ID needs to be an integer; entry is #{trip_hash[:trip_id]}") if trip_hash[:trip_id].class != Integer

      raise ArgumentError.new("Driver ID needs to be an integer; entry is #{trip_hash[:driver_id]}") if trip_hash[:driver_id].class != Integer

      raise ArgumentError.new("Rider ID needs to be an integer; entry is #{trip_hash[:rider_id]}") if trip_hash[:rider_id].class != Integer

      raise ArgumentError.new("Date must be of format YYYY-MM-DD; entry is #{trip_hash[:date]}") if (trip_hash[:date] !~ /^201[4-7]-(0[\d]||1[0-2])-([0-2][\d]||3[01])$/)

      raise BadRatingError.new("Rating needs to be between 1 and 5; entry is #{trip_hash[:rating]}") if trip_hash[:rating].class != Integer || trip_hash[:rating] < 1 || trip_hash[:rating] > 5
    end

  end
end

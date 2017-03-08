module RideShare

  class Trip
  attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    # creates trips that have an ID, rider ID, driver ID, date, and rating
    def initialize(trip_id, driver_id, rider_id, date, rating)
      raise ArgumentError.new("Trip ID must be integer") if trip_id.class != Integer
      raise ArgumentError.new("Driver ID must be integer") if driver_id.class != Integer
      raise ArgumentError.new("Rider ID must be integer") if rider_id.class != Integer
      raise ArgumentError.new("Date must be string") if date.class != String # get more specific here
      raise ArgumentError.new("Rating must be integer") if rating.class != Integer

      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = (1..5).include?(rating.to_i) ? rating.to_i : invalid_rating
    end


    # retrieve the associated driver instance using the driver ID
    def trip_driver
      return RideShare::Driver.find(@driver_id)
    end


    # retrieve the associated rider instance using the rider ID
    def trip_rider
      return RideShare::Rider.find(@rider_id)
    end


    # retrieve all trips from the CSV file and initializes each line as a new trip
    def self.all
      all_trips = []

      CSV.foreach("support/trips.csv", :headers => true).each do | line |
        trip_id = line[0].to_i
        driver_id = line[1].to_i
        rider_id = line[2].to_i
        date = line[3]
        rating = (1..5).include?(line[4].to_i) ? line[4].to_i : invalid_rating

        all_trips << RideShare::Trip.new(trip_id, driver_id, rider_id, date, rating)
      end

      return all_trips
    end


    # find all trip instances for a given driver ID
    def self.drivers_trips(driver_id)
      all_trips = RideShare::Trip.all

      all_trips.reject! { | trip | driver_id != trip.driver_id }

      return all_trips if all_trips.length >= 1 # consider making new exception

      raise ArgumentError.new("Invalid Driver ID in RideShare::Trip #drivers_trips")
    end


    # find all trip instances for a given rider ID
    def self.riders_trips(rider_id)
      all_trips = RideShare::Trip.all

      all_trips.reject! { | trip | rider_id != trip.rider_id }

      return all_trips if all_trips.length >= 1

      raise ArgumentError.new("Invalid Rider ID in RideShare::Trip #riders_trips") # consider making new exception
    end


    private


    def invalid_rating # should make this an exception
      raise ArgumentError.new("Invalid Rating")
    end

  end

end

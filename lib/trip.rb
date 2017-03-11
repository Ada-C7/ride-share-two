require "csv"
# require_relative 'rider'
# require_relative 'driver'

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

    def trip_driver_instance
      RideShareTwo::Driver.find_driver(@driver_id)
    end

    def trip_rider_instance
      RideShareTwo::Rider.find_rider(@rider_id)
    end

# find all trip instances for a given driver ID
    def self.driver_trips(driver_id)
      drivers_trips = []
      all_trips.each do |trip|
        if trip.driver_id.to_i == driver_id
          drivers_trips << trip
        end
      end
      return drivers_trips
    end

    def self.rider_trips(rider_id)
      riders_trips = []
      all_trips.each do |trip|
        if trip.rider_id.to_i == rider_id
          riders_trips << trip
        end
      end
      return riders_trips
    end

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

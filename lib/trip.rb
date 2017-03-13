require 'csv'

# new Trip class, subclass of RideShare
module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating, :all

    # create new trip with id, driver_id, rider_id, date, and rating
    def initialize(trip_info={})
      @id = trip_info[:id].to_i
      @driver_id = trip_info[:driver_id].to_i
      @rider_id = trip_info[:rider_id].to_i
      @date = trip_info[:date]
      @rating = trip_info[:rating].to_f
    end

    # class method: all
    def self.all
      # read in CSV file to create Trip instances
      @all_drivers = []
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/trips.csv", {:headers => true}) do |row|
        @all_drivers << RideShare::Trip.new(
        id: row[0],
        driver_id: row[1],
        rider_id: row[2],
        date: row[3],
        rating: row[4]
        )
      end
      return @all_drivers # return all instances of trips
    end

    # class method: by_rider(rider_id)
    def self.by_rider(rider_id)
      # find all instances of trips where rider_id matches
      all.select { |trip| trip.rider_id == rider_id }
      # returns array of Trip instances
    end

      # class method: by_driver(driver_id)
    def self.by_driver(driver_id)
      # find all instances of trips where driver_id matches
      all.select { |trip| trip.driver_id == driver_id }
      # returns array of Trip instances

    # instance method: find_driver
    def find_driver
      RideShare::Driver.find(@driver_id)
      # returns a Driver instance
    end

  # instance method: find_rider
    def find_rider
      RideShare::Rider.find(@rider_id)
      # returns a Rider instance
    end
  end
end

# attempt to read in only if there was not already a driver with the same id...
# CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/trips.csv", {:headers => true}) do |row| # file directory for rake
#   if @@all_drivers.select { |driver| driver.id == row[0] } != []
#     next
#   else
#     @@all_drivers << RideShare::Trip.new(
#       id: row[0],
#       driver_id: row[1],
#       rider_id: row[2],
#       date: row[3],
#       rating: row[4]
#     )
#   end
# end
# return @@all_drivers # return all instances of trips

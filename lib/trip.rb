require 'csv'

# new Trip class, subclass of RideShare
module RideShare
  class Trip
    # capability to return driver_id or rider_id of trip instance (attr_readers)
    attr_reader :id, :driver_id, :rider_id, :date, :rating, :all

    # initialize trip
    # take in id, driver_id, rider_id, date, rating as a hash
    def initialize(trip_info) # ={}
      @id = trip_info[:id]
      @driver_id = trip_info[:driver_id]
      @rider_id = trip_info[:rider_id]
      @date = trip_info[:date]
      @rating = trip_info[:rating]
    end

    # class method: all
    def self.all
      @all = []
      CSV.foreach("support/trips.csv", {:headers => true}) do |row| # file directory for rake
        @all << RideShare::Trip.new({id: row[0], driver_id: row[1], rider_id: row[2], date: row[3], rating: row[4]})
      end
      return @all
    end
    # for each row in CSV file read in and create an instance of trip
    # return all instances of trips

# class method: trips_rode(rider_id)
# find instances of trips where rider_id matches argument
# alert user if no trips with matching rider_id is found
# return collection of trips by specific rider

# class method: trips_driven(driver_id)
# find instances of trips where driver_id matches argument
# alert user if no trips with matching rider_id is found
# return collection of trips by specific driver

# instance method: find_driver(driver_id)
# return instance of driver

# instance method: find_rider(rider_id)
# for each row in CSV file read in and create an instance of trip
# return instance of rider
  end
end

# p RideShare::Trip.all

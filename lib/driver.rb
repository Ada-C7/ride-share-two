require 'csv'

module RideShare
  class Driver

    attr_reader :id, :name, :phone

    def initialize driver_id, name, vin #order matches csv file
      @id = driver_id
      @name = name
      @vin = vin #check that this is of valid length
    end

    def self.all
      drivers = []
      temp_csv = CSV.read("/Users/sai/Documents/ada/projects/ride-share-two/support/drivers.csv")
      temp_csv.shift #removes first row, which is a header row (thx, google)
      temp_csv.each do |driver|
        drivers << Driver.new(driver[0].to_i, driver[1], driver[2].to_i)
      end

      return drivers
      #check to make sure the entries are valid, if they are not make decisions about how to handle them
    end

    def self.find driver_id
      all_drivers = Driver.all
      return all_drivers.find { |driver| driver_id == driver.id}
    end

    def trips
      return Trip.find_trips_by_driver @id
    end

    def rating
      driver_trips = Trip.find_trips_by_driver @id
      ratings = driver_trips.map { |trip| trip.rating}
      total_rating = ratings.inject(:+).to_f
      return total_rating/driver_trips.length
      #returns average rating of those trips
    end


  end
end

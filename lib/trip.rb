require_relative 'rideshare'

module RideShare
  class Trip
    attr_accessor :id, :driver_id, :rider_id, :date, :rating
    def initialize(id, driver_id, rider_id, date, rating)#Instantiated Trip class with ID, rider ID, a driver ID, date, rating
      @id = id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating#Check rating should be within an acceptable range (1-5) else raise InvalidRatingError
    end

    def driver#Using driver_id find the driver instance from driver class
    end

    def rider#Using rider_id find the rider instance from rider class
    end

    def self.all_trips_driver#Find using driver_id all trips for associater driver instance from all method below
    end

    def self.all_trips_rider#Find using rider_id all trips for associater driver instance from all method below
    end

    def self.all#Use CSV.read method passing file name as argument to retrieve all trips
    end
  end
end

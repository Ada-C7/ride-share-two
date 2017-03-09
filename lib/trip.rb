require_relative 'rideshare'

module RideShare
  class Trip
    attr_accessor :id, :driver_id, :rider_id, :date, :rating
    def initialize(id, driver_id, rider_id, date, rating)#Instantiated Trip class with ID, rider ID, a driver ID, date, rating
      raise ArgumentError.new("The ID is invalid.") if id.class != Fixnum
raise ArgumentError.new("The driver ID is invalid.") if driver_id.class != Fixnum
raise ArgumentError.new("The rider ID is invalid.") if rider_id.class != Fixnum
raise ArgumentError.new("The date is invalid.") if date.class != String
raise InvalidRatingError.new("The rating is invalid.") if rating > 5 || rating < 1

      @id = id.to_i
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating.to_i#Check rating should be within an acceptable range (1-5) else raise InvalidRatingError
    end

    def find_driver#Using driver_id find the driver instance from driver class
      RideShare::Driver.find(@driver_id)
    end

    def find_rider#Using rider_id find the rider instance from rider class
      RideShare::Rider.find(@rider_id)
    end

    def self.trips_by_driver(driver_id)#Find using driver_id all trips for associater driver instance from all method below
      raise ArgumentError.new("The driver ID is invalid.") if driver_id.class != Fixnum
self.all.find_all { |trip| trip.driver_id == driver_id }

    end

    def self.trips_by_rider(rider_id)#Find using rider_id all trips for associater driver instance from all method below
      raise ArgumentError.new("The rider ID is invalid.") if rider_id.class != Fixnum

      self.all.find_all {|trip| trip.rider_id == rider_id}
    end

    def self.all#Use CSV.read method passing file name as argument to retrieve all trips
      CSV.read("support/trips.csv", headers:true ).map do |line|
        RideShare::Trip.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
      end
    end
  end
end

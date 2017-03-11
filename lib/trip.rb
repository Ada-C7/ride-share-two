require 'csv'

module RideShare

  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
      raise ArgumentError.new("Rating must be between 1 and 5") if @rating < 1 || @rating > 5
    end


    def self.all
      trip_array = []
      CSV.open('support/trips.csv', 'r', :headers => true).each do |line|
        trip_id = line["trip_id"].to_i
        driver_id = line["driver_id"].to_i
        rider_id =  line["rider_id"].to_i
        date = line["date"].to_s
        rating = line["rating"].to_i
        trip_array << self.new(trip_id, driver_id, rider_id, date, rating)
      end
      return trip_array
    end

    def self.find(trip_id)
      Trip.all.each do |file|
        if file.trip_id == trip_id
          return file
        end
      end
      raise ArgumentError.new("This account does not exist")
    end

    #Each trip has ID, rider_id, driver_id, date, rating
    #Rating must be between 1-5
    #Retrieve driver instance through driver_id
    #retrieve driver instance through rider_id

    #Reads CSV file in all method

    #create method that uses method from driver to retrieve the associated driver instance
    def trip_get_driver(driver_id)
      RideShare::Driver.find(driver_id)
    end

    #create method that uses method from rider to retrieve the associated rider instance
    def get_rider
      RideShare::Rider.find(rider_id)
    end

    #create a method to retrieve all trips by driver_id
    def self.by_driver(driver_id)
      all.find_all do |trip|
        trip.driver_id == driver_id
      end

    end
    #create a method to retrieve all trips by rider_id
    def self.by_rider(rider_id)
      all.find_all do |trip|
        trip.rider_id == rider_id
      end
    end

  end
end

require 'csv'

# Trip class, subclass of RideShare
module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating, :all

    # creates new trip with id, driver_id, rider_id, date, and rating
    def initialize(trip_info={})
      @id = trip_info[:id].to_i
      @driver_id = trip_info[:driver_id].to_i
      @rider_id = trip_info[:rider_id].to_i
      @date = trip_info[:date]
      @rating = trip_info[:rating].to_f
    end

    # class method: .all  (calls .new)
    def self.all
      @all_drivers = []
      # reads in CSV and create new Trip instances from each row
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/trips.csv", {:headers => true}) do |row|
        @all_drivers << RideShare::Trip.new(
        id: row[0],
        driver_id: row[1],
        rider_id: row[2],
        date: row[3],
        rating: row[4]
        )
      end
      return @all_drivers # array of all Trip instances
    end

    # class method: .by_rider  (calls .all)
    def self.by_rider(rider_id)
      all.select { |trip| trip.rider_id == rider_id }
      # returns all Trip instances for specified rider_id
    end

    # class method: .by_driver  (calls .all)
    def self.by_driver(driver_id)
      all.select { |trip| trip.driver_id == driver_id }
      # returns all Trip instances for specified driver_id
    end

    # instance method: .find_driver  (calls Driver class)
    def find_driver
      RideShare::Driver.find(@driver_id)
      # returns Driver instance associated with this Trip instance
    end

    # instance method: .find_rider  (calls Rider class)
    def find_rider
      RideShare::Rider.find(@rider_id)
      # returns Rider instance associated with this Trip instance
    end
  end
end

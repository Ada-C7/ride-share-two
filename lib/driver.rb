
module Rideshare

  class Driver
    attr_accessor :id, :name, :vin

    def initialize id, name, vin #used by .all to create instances of Drivers
      @id = id
      @name = name
      @vin = vin
    end

    def self.all #method to create instances of Drivers
      @drivers = []

      CSV.open("/Users/adai/Documents/ada/projects/ride-share-two/support/drivers.csv", {:headers => true}).each do |line|
        driver = Rideshare::Driver.new(line[0].to_i, line[1], line[2])
        @drivers << driver #class variable to store all driver objects
      end

    end

    def self.all_drivers #method to return the class variable drivers
      return @drivers
    end


    def self.find id #class method
      raise ArgumentError.new "Not a valid driver id" if id > 100 || id < 1

      Rideshare::Driver.all_drivers.each do |driver|
        if id == driver.id
          puts driver.name
          return driver
        end
      end
    end

    def trips #instance method

      driver_trips = []
      Rideshare::Trips.all_trips.each do |trip|
        if @id == trip.driver_id.to_i
          driver_trips << trip
        end
      end
      return driver_trips #returns all Trip instances in array

    end

    def rating #instance method
      driver_rating = []
      # puts @id.class # integer
      Rideshare::Trips.all_trips.each do |trip|
        if trip.driver_id == @id #both are integers now, still not working
          driver_rating << trip.rating #rating must be integer
        end
      end

      raise ArgumentError.new "Driver has no ratings" if driver_rating.length == 0
      # cannot divide by zero for drivers with no ratings
      total_rating = driver_rating.inject { |sum, n| sum + n }
      return (total_rating / driver_rating.length).round(2)

    end
  end
end

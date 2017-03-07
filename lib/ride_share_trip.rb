require 'csv'
#Create Rideshare module
module Rideshare
#Create Trip class
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating
# trip_id,driver_id,rider_id,date,rating should be initialized
    def initialize(args)
      @trip_id = args[:tirp_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]
      # each rating should be within an acceptable range (1-5)
      raise ArgumentError.new("Not a valid rating") if @rating > 5 || @rating < 0
    end

#self.method1 : find all trip instances for a given driver ID
    def self.find_driver(driver_id)
      Rideshare::Driver.find(driver_id)
    end

    def self.find_rider(rider_id)
      Rideshare::Rider.find(rider_id)
    end

#self.method2 : find all trip instances for a given rider ID

#self.method3 : retrieve all trips from the CSV file

#instance_method1 : retrieve the associated driver instance through the driver ID

#instance_method2 : retrieve the associated rider instance through the rider ID

  end
end

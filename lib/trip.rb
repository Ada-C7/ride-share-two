module Rideshare
  class Trip
    attr_accessor :driver_id, :rider_id, :rating, :trip_id

    def initialize(trip_hash)

      @trip_id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
      raise MissingIdError.new("That is an invalid driver id") if @driver_id.to_i > 100 || @driver_id.to_i < 0
      raise InvalidDataError.new("That is an invalid rating, ratins must be between 1 and 5.") if @rating.to_i > 5 || @rating.to_i < 1
      raise MissingIdError.new("That is an invalid rider id") if @rider_id.to_i >= 301 || @rider_id.to_i < 0

    end

    def self.create_trips
      array = []
      #Opens the CSV file and creates an array of trip objects
      CSV.foreach('support/trips.csv', {:headers => true}) do |row|
       array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]})
     end
     return array
    end


    def self.find_by_driver(param)

      trip_array = Trip.create_trips.select{|value| value.driver_id== param.to_s}
      raise MissingIdError.new("That driver has not taken any trips") if trip_array.length < 1
      return trip_array

    end

    def self.find_by_rider(param)
      array = Trip.create_trips.select{|value| value.rider_id== param.to_s}
      raise MissingIdError.new("That rider has not taken any trips") if array.length < 1
      return array
    end

    def make_driver
      Driver.find_driver(self.driver_id)
    end

    def make_rider
      Rider.find_rider(self.rider_id)

    end
  end
end

require 'csv'


module RideShare

  class Trips
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id  = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating

    end

    def self.all
      all_trips = []

      csv_data = CSV.read("support/trips.csv")
      csv_data.shift

      csv_data.each do |line|
        all_trips << Trips.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
      end
      return all_trips
    end

    def self.find(trip_id)
      trips = RideShare::Trips.all
      return trips.find {|trip| trip.trip_id == trip_id }
    end

    def to_s
      "trip_id: #{ @trip_id }, driver_id: #{ @driver_id }, rider_id: #{ @rider_id },
      date: #{ @date }, rating: #{ @rating }."
    end
  end

end

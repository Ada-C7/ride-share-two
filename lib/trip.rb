require 'csv'
module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(info)
      @id = info[:id]
      @driver_id = info[:driver_id]
      @rider_id = info[:rider_id]
      @date = info[:date]
      @rating = info[:rating]
    end

    def self.all(csv_file)
      trips = CSV.read(csv_file)
      trips.shift
      trips.map! do |trip_info|
        trip = Hash.new
        trip[:id] = trip_info[0].to_i
        trip[:driver_id] = trip_info[1].to_i
        trip[:rider_id] = trip_info[2].to_i
        # want date to be date object?
        trip[:date] = trip_info[3]
        trip[:rating] = trip_info[4].to_i
        trip_info = trip
      end

      trips.map! { |info| self.new(info) }
      return trips
    end
  end
end

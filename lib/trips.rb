require 'csv'

module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_details)
      @id = trip_details[:id]
      @driver_id = trip_details[:driver_id]
      @rider_id = trip_details[:rider_id]
      @date = trip_details[:date]
      @rating = trip_details[:rating]

      if @rating < 1 || @rating > 5
        then @rating = nil
      end
    end

    def self.read_csv
      @@trips = []
      if @@trips.empty?
        CSV.foreach("support/trips.csv", {:headers => true}) do |line|
          @@trips << self.new({id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3].to_s, rating: line[4].to_f})
        end
      end
      return @@trips
    end

    def self.getAll
      return read_csv
    end

    def self.getDriver(id)
      trip_object = nil
      getAll().each do |trip|
        if trip.id == id
          trip_object = trip
        end
      end
      return Driver.find(trip_object.driver_id)
    end

    def self.getRider(id)
      trip_object = nil
      getAll().each do |trip|
        if trip.id == id
          trip_object = trip
        end
      end
      Rider.find(trip_object.rider_id)
    end

    def self.getTripsByDriver(driver_id)
      return getAll().select { |trip| trip.driver_id == driver_id
      }
    end

    def self.getTripsByRider(rider_id)
      return getAll().select { |trip| trip.rider_id == rider_id
      }
    end
  end
end

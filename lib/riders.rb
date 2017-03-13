require 'csv'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_num

    def initialize(rider_details)
      @id = rider_details[:id]
      @name = rider_details[:name]
      @phone_num = rider_details[:phone_num]
    end

    def self.readCSV
      @@riders = []
      if @@riders.empty?
        CSV.foreach("support/riders.csv", {:headers => true}) do |line|
          @@riders << self.new({id: line[0].to_i, name: line[1].to_s, phone_num: line[2].to_s})
        end
      end
      return @@riders
    end

    def self.getAll
      return readCSV
    end

    def self.find(id)
      rider_details = nil
      getAll().each do |rider|
        if rider.id == id
          rider_details = rider
        end
      end
      return rider_details
    end

    def findTrips
      return Trip.getTripsByRider(@id)
    end

    def findDrivers
      drivers = []
      rider_trips = findTrips()
      rider_trips.each do |trip|
        driver_object = RideShare::Driver.find(trip.driver_id)
        drivers << driver_object
      end
      return drivers.uniq { |driver| driver.id }
    end
  end
end

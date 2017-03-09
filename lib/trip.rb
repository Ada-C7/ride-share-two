module Carmmunity
  class Trip
  #@@trips = {} #or array

  attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

  def initialize(trip_hash)
    @trip_id = trip_hash[:trip_id]
    @driver_id = trip_hash[:driver_id]
    @rider_id = trip_hash[:rider_id]
    @date = trip_hash[:date]
    @rating = trip_hash[:rating] #(1-5) <-method?
  end


  def find_driver

  driver = Carmmunity::Driver::find(@driver_id)

  return driver
  end

  def find_rider

    rider = Carmmunity::Rider::find(@rider_id)

    return rider
  end


  def self.driver_trips(id)

    all_trips = self.all

    driver_trips = all_trips.map do |trip|
      trip if trip.driver_id == id
    end

    return driver_trips
  end


  def self.rider_trips(id)

    all_trips = self.all

    rider_trips = []

    all_trips.each do |trip|

      rider_trips << trip if trip.rider_id == id
    end

    return rider_trips
  end


  def self.all

    #if @@trips.length == 0
    trips = []

      CSV.read("support/trips.csv").each do |row|
        trip = {
          trip_id: row[0].to_i,
          driver_id: row[1].to_i,
          rider_id: row[2].to_i,
          date: row[3],
          rating: row[4].to_i

        }

        trips << Carmmunity::Trip.new(trip)
        #@@Trips << Carmmunity::Driver.new(trip)

      end
    #end
    return trips#@@trips
  end #

  end
end

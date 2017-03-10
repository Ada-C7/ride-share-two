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

    driver = Driver.find(@driver_id)

    return driver
  end

  def find_rider

    rider = Rider.find(@rider_id)

    return rider
  end


  def self.driver_trips(id)

    trips = Trip.all.select {|trip| trip.driver_id == id }

    # driver_trips = all_trips.map do |trip|
    #   trip if trip.driver_id == id
    # end

    return trips
  end


  def self.rider_trips(id)

    trips = Trip.all.select {|trip| trip.rider_id == id }

    return trips
  end


  def self.all
    #is is best practice to read the csv file every time?
    @@trips = []

    if @@trips.length == 0


      CSV.read("support/trips.csv").each do |row|
        trip = {
          trip_id: row[0].to_i,
          driver_id: row[1].to_i,
          rider_id: row[2].to_i,
          date: row[3],
          rating: row[4].to_i
        }

        @@trips << Carmmunity::Trip.new(trip)
      end
    end
    return @@trips
  end #end of self.all

  end
end

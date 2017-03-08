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


  #def find_driver
  #driver = Driver::find(@driver_id) #using the self.find method from driver class
  #return driver
  #end

  #def find_rider
  #rider = Rider::find(@rider_id)
  #return rider

  #self.find(driver_id)
  #from @@trips find all trips with associated driver
  #return trips
  #end
  def self.find_driver(id)

    #@@trips.find do |trip|

    all_trips = self.all

    all_trips.find do |driver|

      if driver.driver_id == id
        return driver
      end
    end
  end

  #self.find(rider)
  #from @@trips find all trips with associated rider
  #return trips
  #end

  def self.find_rider(id)
    rider = Carmmunity::Rider::find(id)
    return rider
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

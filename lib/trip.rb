# Each trip should:
#
# have an ID, rider ID, a driver ID, date, rating
# Each rating should be within an acceptable range (1-5)

# Given a trip object, you should be able to:
#

# retrieve the associated driver instance through the driver ID
# retrieve the associated rider instance through the rider ID
# You should be able to:
#

# find all trip instances for a given driver ID
# find all trip instances for a given rider ID
# retrieve all trips from the CSV file

class Trip

attr_accessor :trip_id, :driver_id, :rider_id, :date, :rating

  def initialize()
    @trip_id = hash[:trip_id]
    @driver_id = hash[:driver_id]
    @rider_id = hash[:rider_id]
    @date = hash[:date]
    @rating = hash[:rating]
  end

  #per trip object
  def self.all
    trips = []
    trips_master = CSV.read("support/trips.csv")
    trips_master.delete_at(0)
    trips_master.each do |line|
      trip_hash = {}
      trip_hash[:trip_id] = line[0].to_i
      trip_hash[:driver_id] = line[1]
      trip_hash[:rider_id] = line[2]
      trip_hash[:date] = line[3]
      trip_hash[:rating] = line[4]
      trips << Trip.new(trip_hash)
    end
    return trips

  end


  def self.find
    #meth 1

  end

  def trip_driver(id)
    #meth 2 instances by driver/unique to driver id
    #trips.with_driver()
  end


  def trip_rider(id)
    #meth 3 instances unique to rider
    #trips
  end


  def trips_by_driver
    #per rider object, return array of trip instances unique to driver
  end


  def trips_by_rider
    #per rider object, return array of trip instances unique to rider
  end

end
 #class end

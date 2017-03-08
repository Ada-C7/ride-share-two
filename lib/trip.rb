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

attr_accessor :id, :rider_id, :driver_id, :date, :rating

  def initialize()
    @id = hash[:id]
    @rider_id = hash[:rider_id]
    @driver_id = hash[:driver_id]
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
      trip_hash[:id] = line[0].to_i
      trip_hash[:name] = line[1]
      trip_hash[:vehicle_id] = line[2]
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

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
require 'csv'
require 'pry'

class Rider

attr_accessor :id, :rider_id, :date, :rating

def initialize()
  @id = hash[:id]
  @rider_id
  @date = hash[:id]
  @rating = hash[:vehicle_id]
end


def find_all
  #find previous driver instances for this rider instance
end

def trip_driver(id)
end

def trip_rider(id)

end

def trips_by_driver
  #per rider object, find array of trip instances unique to driver
end

def trips_by_rider
  #per rider object, find array of trip instances unique to rider
end

def self.all #read in from csv
  riders = []
  riders_master = CSV.read("support/riders.csv")
  riders_master.delete_at(0)
  riders_master.each do |line|
    rider_hash = {}
    rider_hash[:id] = line[0].to_i
    rider_hash[:name] = line[1]
    rider_hash[:vehicle_id] = line[2]
    riders << Rider.new(riders_hash)
  end
  return drivers
end


def drivers_past(id)
end








end

# #Each rider should:
#
# have an ID, name and phone number

# Given a rider object, you should be able to:
#
# retrieve the list of trip instances that only this rider has taken

# retrieve the list of all previous driver instances (through the trips functionality built above) #DRIVERS(TRIPS)

# You should be able to:
#
# retrieve all riders from the CSV file

# FIND a specific rider using their numeric ID

require 'csv'
require 'pry'

class Rider

attr_accessor :rider_id, :name, :phone

def initialize()
  @rider_id = hash[:rider_id]
  @name = hash[:name]
  @phone = hash[:phone]
end


def self.all #read in from csv
  riders = []
  riders_master = CSV.read("support/riders.csv")
  riders_master.delete_at(0)
  riders_master.each do |line|
    rider_hash = {}
    rider_hash[:rider_id] = line[0].to_i
    rider_hash[:name] = line[1]
    rider_hash[:phone] = line[2]
    riders << Rider.new(riders_hash)
  end
  return riders
end


def riders_trips
  #find previous driver instances for this rider instance
end


def rider_drivers(trips)
  # retrieve the list of all previous driver instances (through the trips functionality built above) #DRIVERS(TRIPS)
end


def drivers_past(id)
  # retrieve the list of all previous driver instances (through the trips functionality built above) #DRIVERS(TRIPS)
end








end

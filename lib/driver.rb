# Each driver should:
#
# have an ID, name and vehicle identification number
# Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number

# Given a driver object, you should be able to:
# retrieve the list of trip instances that only this driver has taken
# retrieve an average rating for that driver based on all trips taken

# You should be able to:
## retrieve all drivers from the CSV file
## find a specific driver using their numeric ID

require 'csv'
require 'pry'

class Driver

  attr_accessor :driver_id, :name,  :vehicle_id


  def initialize(hash)
    @driver_id = hash[:driver_id]
    @name = hash[:name]
    @vehicle_id = hash[:vehicle_id]
  end


  def self.all
    drivers = []
    drivers_master = CSV.read("support/drivers.csv")
    drivers_master.delete_at(0)
    drivers_master.each do |line|
      driver_hash = {}
      driver_hash[:driver_id] = line[0].to_i
      driver_hash[:name] = line[1]
      driver_hash[:vehicle_id] = line[2]
      drivers << Driver.new(driver_hash)
    end
    return drivers
  end


  def self.find(driver_id)
    all_drivers = Driver.all
    find_driver = nil
    all_drivers.each do |driver|
      find_driver = driver if driver.id == driver_id
    end
    raise ArgumentError.new("Drivers don't match") if find_driver == nil
    return find_driver
    #think of above loop as searching to reset from nil
  end


  def driver_trips
    driver_trips = []
    #local_var = class object.class_method(pass arg)
    driver_trips = Trip.trips_by_driver(@driver_id)
    #retrieve a list of trip instances that only this driver has taken
  end


  def driver_rating
    #retrieve an average rating for that driver based on all trips taken# driver_trips(ratings)

    # trips.all[4].map { |rating| ratings.sum ratings.average }
  end


  def check_vin_length
    # valid_vehicle_id?(length)
    #valid_length = 17
    #drivers_master[2].length
  end

end

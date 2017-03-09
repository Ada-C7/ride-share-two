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
      # if line[2].length != 17
      #   raise Invalid_ID.new("This is not a valid id.")
        drivers << Driver.new(driver_hash)
    end
    return drivers
  end


  def self.find(driver_id)
    all_drivers = Driver.all
    find_driver = nil
    all_drivers.each do |driver|
      find_driver = driver if driver.driver_id == driver_id
    end
    raise ArgumentError.new("Drivers don't match") if find_driver == nil
    return find_driver
    #think of above loop as searching to reset from nil
  end


  def driver_trips
    driver_trips = []
    #local_var[] = class object.class_method(pass arg)
    driver_trips = Trip.trips_by_driver(@driver_id)
  end


  def driver_rating
    trips = driver_trips
    ratings = []
    ratings = trips.map { |trip| trip.rating.to_f }
    average_rating = ratings.inject(0.0) { |sum, el| sum + el } / ratings.size
    return average_rating
  end
end

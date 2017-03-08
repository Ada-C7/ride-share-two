require 'csv'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name
    @vin = vin
  end

  def self.all
    # read SCV
    # returns a list of driver instances
    drivers = CSV.read("support/drivers.csv", { :headers => true })
    # drivers_array = []

    # drivers.each do |line|
    #   drivers_array << Driver.new(line[0].to_i, line[1], line[2])
    # end

    drivers.map { |line| Driver.new(line[0].to_i, line[1], line[2]) }

    #return drivers_array
  end

  def self.find(driver_id)
    # searches .all for all driver matching parameter
    # returns an instance of a driver
    # Driver.all.each do |driver|
    #   if driver.id == driver_id
    #     return driver
    #   end
    # end
    found_driver = Driver.all.find { |driver| driver.id == driver_id }
    return found_driver if found_driver
    # create a special NoDriver error, maybe rescue it?
    raise ArgumentError.new("driver #{driver_id} does not exist")

  end

  def list_trips
    # passes driver ID to find_trips_per_driver
    # returns a list of trip instances only this driver has taken
    Trip.find_trips_driver(@id)
  end

  def avg_rating
    # accesses rating form each trip instance
    # calcualtes average
    # returns an average rating for that driver based on all trips taken
  end

end

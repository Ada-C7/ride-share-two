require 'csv'
require 'ap'
require_relative 'trip.rb'

class Driver
  attr_reader :id, :name, :vin
  def initialize(id, name, vin)
    @id = id
    @name = name
    @vin = vin
    raise ArgumentError.new("vin number should be exactly 17") unless @vin.length == 17
  end

  def self.all
    @drivers = []
    CSV.foreach("./support/drivers.csv", {:headers => true}).each do |line|
      @drivers << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
    end
    return @drivers
  end

  def self.find(id)
    driver_find = Driver.all
    driver_find.each do |driver|
      if driver.id == id
        return driver
      end
    end
    raise ArgumentError.new "Sorry, a driver with ID:#{id} doesn't exist."
  end

  def trip_instances_for_driver
    Trip.find_driver(id)
    #write test for this
  end

end

# ap Driver.find(9)
# ap Trip.find_driver(9)
# ap Driver.all
one_driver = Driver.find(1)
ap one_driver.trip_instances_for_driver

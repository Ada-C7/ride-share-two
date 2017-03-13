require 'csv'
require 'ap'
require_relative 'trip'

module RideShare
  class Driver
    attr_reader :id, :name, :vin
    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin
      raise ArgumentError.new("vin number should be exactly 17") unless @vin.length == 17
    end

    #retrieve all drivers from the CSV file
    def self.all
      @drivers = []
      CSV.foreach("./support/drivers.csv", {:headers => true}).each do |line|
        @drivers << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      return @drivers
    end

    #find a specific driver using their numeric ID
    def self.find(id)
      driver_find = RideShare::Driver.all
      driver_find.each do |driver|
        if driver.id == id
          return driver
        end
      end
      raise ArgumentError.new "Sorry, a driver with ID:#{id} doesn't exist."
    end

    #retrieve the list of trip instances that only this driver has taken
    def trip_instances_for_driver
      list_instances_of_trips = RideShare::Trip.find_trips_of_driver(id)
      if list_instances_of_trips.length == 0
        raise ArgumentError.new "Sorry, there is no driver with an ID:#{id}."
      else
        return list_instances_of_trips
      end
    end

    #retrieve an average rating for that driver based on all trips taken
    def rating
      trips = RideShare::Trip.find_trips_of_driver(id)
      total = 0
      array = trips.map{|item_in_object| item_in_object.rating }
      array.each {|x| total += x.to_f}
      average = (total/array.length)
      return average.round
    end

  end    #end of class
end  #end of module


# puts "creates instance for non-self methods"
# instance_of_driver = RideShare::Driver.find(9)

# puts "retrieve the list of trip instances that only this driver has taken"
# ap instance_of_driver.trip_instances_for_driver

# puts "retrieve an average rating for that driver based on all trips taken"
# ap instance_of_driver.rating

# puts "retrieve all drivers from the CSV file"
# ap RideShare::Driver.all

# puts "find a specific driver using their numeric ID"
# ap RideShare::Driver.find(9)

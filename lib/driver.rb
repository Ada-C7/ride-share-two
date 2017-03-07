require 'csv'

module RideShare
  attr_reader :id, :name, :vin
  class Driver

    #Each Driver should have an ID, name, VIN
    def initialize(id, name, vin)
      @id = id.to_i
      @name = name
      @vin = vin
    #Vin should be a specific length to ensure validity(raise error)
    end #end initialize method

    def self.all
      driver_hash = {}
      CVS.read("support/drivers.csv").each do |line|
        id = line[0].to_i
        name = line[1]
        vin = line[2]
        driver_hash[id] = self.new(id, name, vin)
      end
      return driver_hash
    end

    def self.find(id)
      return self.all(id)
    end
    #Should be able to retrieve list of trip instances that a specific driver has taken
    #Should be able to retrieve the average rating for that driver based on all trips taken
    #Have to use all method in find method
    #create method that uses method from trip object to retrieve list of trips
    #create method that uses internal trips list to calculate average rating
  end
end
